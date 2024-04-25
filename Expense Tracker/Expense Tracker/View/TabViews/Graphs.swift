//
//  Graphs.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI
import SwiftData
import Charts

struct Graphs: View {
    /// View Properties
    @Query(animation: .snappy) private var transactions: [Transaction]
    @State private var chatGroups: [ChartGroup] = []
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 10) {
                    /// Chart View
                    ChartView()
                        .padding(10)
                        .padding(.top,  10)
                        .frame(height: 200)
                        .background(.background, in: .rect(cornerRadius: 10))
                    
                    ForEach(chatGroups) { group in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(formatDate(group.date, format: "yyyy-MM-dd"))
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .hSpacing(.leading)
                            
                            NavigationLink {
                                ListOfExpense(month: group.date  )
                            } label: {
                                CardView(income: group.totalIncome, expense: group.totalExpense)
                            }
                            .buttonStyle(.plain)

                            
                            
                        }
                        
                    }
                }
                .padding(15)
            }
            .navigationTitle("Graphs")
            .background(.gray.opacity(0.15))
            .onAppear {
                /// Create Chart Group
                createChartGroup()
            }
        }
    }
    
    @ViewBuilder
    func ChartView() -> some View {
        Chart {
            ForEach(chatGroups) { group in
                ForEach(group.categories) { chart in
                    BarMark(
                        x: .value("Month", formatDate(group.date, format: "yyyy-MM")),
                        y: .value(chart.category.rawValue, chart.totalValue)
                    )
                    .position(by: .value("Category", chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category", chart.category.rawValue))
                }
            }
        }
        /// Making Chart Scrollable
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom, alignment: .trailing)
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                let doubleValue = value.as(Double.self) ?? 0
                
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    Text(axisLabel(doubleValue))
                }
            }
        }
        /// Foreground Colors
        .chartForegroundStyleScale(range: [Color.green.gradient, Color.red.gradient  ])
    }
    
    func createChartGroup() {
        Task.detached(priority: .high) {
            let calendar = Calendar.current
            
            let groupedByDate = Dictionary(grouping: transactions) { transcation in
                let components = calendar.dateComponents([.month, .year], from: transcation.dateAdded)
                
                return components
            }
            
            /// Sorting Groups By Date
            let sortedGroups = groupedByDate.sorted {
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroups = sortedGroups.compactMap { dict -> ChartGroup? in
                let date = calendar.date(from: dict.key) ?? .init()
                let income = dict.value.filter( { $0.category == Category.income.rawValue })
                let expense = dict.value.filter( { $0.category == Category.expense.rawValue })
                
                let incomeTotalValue = total(income, category: .income)
                let expenseTotalValue = total(expense, category: .expense)
                
                return .init(
                    date: date,
                    categories: [
                        .init(totalValue: incomeTotalValue, category: .income),
                        .init(totalValue: expenseTotalValue, category: .expense)
                    ],
                    totalIncome: incomeTotalValue,
                    totalExpense: expenseTotalValue
                )
            }
            
            await MainActor.run {
                self.chatGroups = chartGroups
            }
        }
    }
    
    func axisLabel(_ value: Double) -> String {
        let intValue = Int(value)
        let kValue = intValue / 1000
         
        return intValue < 1000 ? "\(intValue)" :  "\(kValue)K"
    }
}
  
/// List Of Transaction For  the Selected Month
struct ListOfExpense: View {
    let month: Date
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                Section {
                    FilterTransactionView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .income    ) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                } header: {
                    Text("Income")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
                
                Section {
                    FilterTransactionView(startDate: month.startOfMonth, endDate: month.endOfMonth, category: .expense) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                } header: {
                    Text("Expense")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }
            }
            .padding(15)
        }

        .background(.gray.opacity(0.15 ))
        .navigationTitle(formatDate(month, format: "yyyy-MM "))
        
    }
    
}

#Preview {
    Graphs()
}
