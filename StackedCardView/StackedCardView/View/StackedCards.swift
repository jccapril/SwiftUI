//
//  StackedCards.swift
//  StackedCardView
//
//  Created by Jason on 2024/5/17.
//

import SwiftUI

struct StackedCards<Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var items: Data
    var stackedDisplayCount: Int = 2
    var spacing: CGFloat = 5
    var itemHeight: CGFloat
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.vertical) {
                VStack(spacing: spacing) {
                    ForEach(items) { item in
                        content(item)
                            .frame(height: itemHeight)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)  
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        }
    }
}

#Preview {
    ContentView()
}
