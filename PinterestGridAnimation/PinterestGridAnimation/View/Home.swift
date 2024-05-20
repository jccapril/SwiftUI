//
//  HOme.swift
//  PinterestGridAnimation
//
//  Created by Jason on 2024/5/20.
//

import SwiftUI

struct Home: View {
    /// UI Properties
    var coordinator: UICoordinator = .init()
    @State private var posts: [Item] = smapleImages
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15){
                Text("Welcome Back")
                    .font(.largeTitle)
                    .padding(.vertical, 10)
                
                /// Grid Image View
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                    ForEach(posts) { post in
                        PostCardView(post)
                    }
                }
            }
            .padding(15)
            .background(ScrollViewExtractor {
                coordinator.scrollView = $0
            })
        } 
        .opacity(coordinator.hideRootView ? 0 : 1)
        .overlay {
            Detail()
                .environment(coordinator)
        }
    }
    
    
    @ViewBuilder
    func PostCardView(_ post: Item) -> some View {
        GeometryReader {
            let frame = $0.frame(in: .global)
            ImageView(post: post)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    coordinator.selectedItem = post
                    /// Store View's Rect
                    coordinator.rect = frame
                    /// Generating ScrollView's Visible area Snapshot
                    coordinator.createVisibleAreaSnapshot()
                    coordinator.hideRootView = true
                    // Animating View
                    withAnimation(.easeInOut(duration:  0.3), completionCriteria: .removed) {
                        coordinator.animateView = true
                    } completion: {
                          
                    }
                }
        }
        .frame(height: 180)
    }
}

#Preview {
    ContentView()
}
