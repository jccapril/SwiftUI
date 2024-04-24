//
//  TransactionCardView.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI
  
struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var showCategory: Bool = false
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient , in: .circle)
                
                VStack(alignment: .leading ,spacing: 4) {
                    Text(transaction.title)
                        .foregroundStyle(.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(.primary.secondary)
                    
                    Text(transaction.dateAdded.format(format: "yyyy-MM-dd"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    if showCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .padding(.horizontal, 8 )
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(transaction.category == Category.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                    }
                      
                }
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: appTint, icon: "trash") {
                context.delete(transaction) 
            }
        }

    }
}

 
 #Preview {
    ContentView() 
}
