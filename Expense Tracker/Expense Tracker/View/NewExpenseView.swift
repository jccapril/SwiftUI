//
//  NewExpenseView.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/18.
//

import SwiftUI

struct NewExpenseView: View {
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    /// View's Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expense
    /// Radom Tint
    @State private  var tint: TintColor = tints.randomElement()!
    var body: some View {
          ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                /// Preview Transcation Card View
                TransactionCardView(
                    transaction:
                        Transaction(
                            title: title.isEmpty ? "Title" : title,
                            remarks: remarks.isEmpty ? "Remarks" : remarks,
                            amount: amount,
                            dateAdded: dateAdded,
                            category: category,
                            tintColor: tint
                        )
                )
                
                CustomSectionView(label: "Title", hint: "Magic Keyboard", value: $title)
                
                CustomSectionView(label: "Remarks", hint: "Apple Product! ", value: $remarks)
                
                // Amount & Category Check Box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        HStack(spacing: 4) { 
                            Text(currencySymbol)
                                .font(.callout  .bold())
                            
                            TextField("0.00", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        /// Custom Checkbox
                        CategoryCheckBox()
                    }
                })
                
                
                // Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .tint(appTint)
                })
                
            }
            .padding(15)
        }
          .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transcation")
        .background(.gray.opacity(0.15))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
                    .tint(appTint)
            }
        }
        .onAppear(perform: {
            if let editTransaction {
                title = editTransaction.title
                remarks = editTransaction.remarks
                amount = editTransaction.amount
                dateAdded = editTransaction.dateAdded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
            }
        })
    }
    
    /// Save Data
    func save() {
        // Saving Item to SwiftData
        if let editTransaction {
            editTransaction.title = title
            editTransaction.dateAdded = dateAdded
            editTransaction.remarks = remarks
            editTransaction.amount = amount
            editTransaction.category = category.rawValue 
        }else {
            let transcation = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
            context.insert(transcation)
        }
       
        // Dimissing View
        dismiss() 
    }
    
    @ViewBuilder
    func CustomSectionView(label: String, hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        }
    }
    
    
    /// Custom CheckBox
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(category.rawValue)
                }
                .containerShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    /// Number Format
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    NavigationStack {
        NewExpenseView()
    }
}
