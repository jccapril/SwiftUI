//
//  ContentView.swift
//  LockSwiftUI
//
//  Created by Jason on 2024/4/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LockView(lockType: .biometric , lockPin: "0320", isEnabled: true, lockWhenAppGoesBackground: true) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
