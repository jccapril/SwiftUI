//
//  Settings.swift
//  Expense Tracker
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

struct Settings: View {
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    /// App Lock Properties
    @AppStorage("isAppLockEnbale") private var isAppLockEnbale: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("User Name"){
                    TextField("iJustine", text: $userName)
                }
                
                Section("App Lock"){
                    Toggle("Enable App Lock", isOn: $isAppLockEnbale)
                    
                    if isAppLockEnbale {
                        Toggle("Lock When App Goes Background", isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}

#Preview {
   ContentView()
}
