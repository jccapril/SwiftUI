//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
