//
//  Tab.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

enum Tab: LocalizedStringKey {
    case recents = "Recents"
    case search = "Filters"
    case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabConentView: some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    } 
}

