//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

struct ContentView: View {
    /// Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    /// App Lock Properties
    @AppStorage("isAppLockEnbale") private var isAppLockEnbale: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    /// Active Tab
    @State private var activeTab: Tab = .recents
    var body: some View {
        LockView(lockType: .both, lockPin: "0409", isEnabled: isAppLockEnbale, lockWhenAppGoesBackground: lockWhenAppGoesBackground) {
            TabView(selection: $activeTab) {
                Recents()
                    .tag(Tab.recents)
                    .tabItem { Tab.recents.tabConentView  }
                
                Search()
                    .tag(Tab.search)
                    .tabItem { Tab.search.tabConentView  }
                
                Graphs()
                    .tag(Tab.charts)
                    .tabItem { Tab.charts.tabConentView  }
                
                Settings()
                    .tag(Tab.settings)
                    .tabItem { Tab.settings.tabConentView  }
            }
            .tint(appTint)
            .sheet(isPresented: $isFirstTime) {
                IntroScreen()
                    .interactiveDismissDisabled()
            }
        }
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
