//
//  Recents.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

struct Recents: View {
    /// User Properties
    @AppStorage("username") private var userName: String = ""
    /// View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    @State private var showDateFilterView: Bool = false
    /// For Animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            /// For Animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        
                        Section {
                            // Date Filter Button
                            Button(action: {
                                showDateFilterView = true
                            }, label: {
                                Text("\(startDate.format(format: "yyyy-MM-dd")) ~ \(endDate.format(format: "yyyy-MM-dd"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray )
                            })
                            .hSpacing(.leading)
                            
                            // CardView
                            CardView(income: 2310, expense: 4550)
   
                            // Custom Segmented Control
                            CustomSegementControl()
                                .padding(.bottom, 10)
                             
                            // TransactionCardView
                            ForEach(sampleTransactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                SwipeAction(cornerRadius: 10) {
                                    TransactionCardView(transaction: transaction)
                                } actions: {
                                    Action(tint: .red, icon: "trash.fill") {
                                        withAnimation(.easeInOut) {
                                            
                                        }
                                    }
                                }

                               
                            }
                            
                            
                        } header: {
                            HeaderView(size)
                        }
                        
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showDateFilterView ? 8 : 0)
                .disabled(showDateFilterView)
            }
            .overlay {
                if showDateFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showDateFilterView = false
                    }, onClose: {
                        showDateFilterView = false
                    })
                    .transition(.move(edge: .leading ))
                }
            }
            .animation(.snappy , value: showDateFilterView )
           
        }
    } 
    /// Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize ) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            })
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
                
            }

        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                 
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }

    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = min( max(progress, 0), 1) * 0.4
        return 1 + scale
    }
    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY/15)
    }
    
    /// Segment Control
    @ViewBuilder
    func CustomSegementControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id:\.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
                
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
    
}

#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}

#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "zh-Hans"))
}
