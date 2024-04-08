//
//  ContentView.swift
//  InteractiveFloatingButton
//
//  Created by Jason on 2024/4/7.
//

import SwiftUI

struct ContentView: View {
    
    @State private var colors: [Color] = [
        .red, .blue, .green, .yellow, .cyan, .orange, .purple, .pink, .brown
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing:15, content: {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(color.gradient)
                            .frame(height: 200)
                    }
                })
                .padding(15)
            }
            .navigationTitle("Floating Button")
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                FloatingAction(symbol: "tray.full.fill") {
                    print("Tray")
                }
                FloatingAction(symbol: "lasso.badge.sparkles") {
                    print("Spark")
                }
                FloatingAction(symbol: "square.and.arrow.up.fill") {
                    print("Share")
                }
            } label: { isExpanded in
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                    .scaleEffect(1.02)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black, in: .circle)
                    // Scale Effect When Expanded
                    .scaleEffect(isExpanded ? 0.9 : 1.0)
            }
            .padding()


        }
    }
}

#Preview {
    ContentView()
}
