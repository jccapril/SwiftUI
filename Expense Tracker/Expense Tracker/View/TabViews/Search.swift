//
//  Search.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI
import Combine

struct Search: View {
    /// View's Properties
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    @State private var selectedCategory: Category? = nil
    let searchPublisher = PassthroughSubject<String, Never>()
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    FilterTransactionView(category: selectedCategory, searchText: searchText) { transactions in
                        ForEach(transactions) { transaction in
            
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction, showCategory: true)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                }
                .padding(15)
            }
            .overlay {
                ContentUnavailableView("Search Transaction", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue )
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
                print(text)
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            }
        }
    }
    
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            Button(action: {
                selectedCategory = nil
            }, label: {
                HStack {
                    Text("Both")
                    if selectedCategory == nil {
                        Image(systemName: "checkmark")
                    }
                }
            })
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button(action: {
                    selectedCategory = category
                }, label: {
                    HStack {
                        Text(category.rawValue)
                        
                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }
    }
}

#Preview {
    ContentView()
}
