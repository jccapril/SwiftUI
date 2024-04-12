//
//  ContentView.swift
//  CustomSwipeAction
//
//  Created by Jason on 2024/4/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Messages")
        }
    }
}

#Preview {
    ContentView()
}
