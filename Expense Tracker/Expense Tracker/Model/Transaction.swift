//
//  Transactiion.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI
import SwiftData

@Model
class Transaction  {
//    let id: UUID = .init()
    /// Properties
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    /// Extracting Color Value From tintColor String
    var color: Color {
        tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
}

/// Sample Transactions For UI Bind
//
