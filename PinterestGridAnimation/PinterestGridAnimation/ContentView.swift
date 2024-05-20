//
//  ContentView.swift
//  PinterestGridAnimation
//
//  Created by Jason on 2024/5/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
