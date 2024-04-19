//
//  ContentView.swift
//  CustomToasts
//
//  Created by Jason on 2024/4/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Presss Toast") {
                Toast.shared.present(title: "Toast", symbol: "globe", duration: .medium)
            }
        }
        .padding()
    }
}

#Preview {
    RootView {
        ContentView()
    } 
}
