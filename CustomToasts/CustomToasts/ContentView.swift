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
                Toast.shared.present(
                    title: "AirPods Pro",
                    symbol: "airpodspro",
                    isUserInteractionEnabled: true,
                    duration: .long
                )
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
