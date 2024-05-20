//
//  Detail.swift
//  PinterestGridAnimation
//
//  Created by Jason on 2024/5/20.
//

import SwiftUI

struct Detail: View {
    @Environment(UICoordinator.self) private var coordinator
    var body: some View {
        GeometryReader {
            let size = $0.size
            let animateView = coordinator.animateView
            let hideView = coordinator.hideRootView
            let hideLayer = coordinator.hideLayer
            let rect = coordinator.rect
            let anchorX = (coordinator.rect.minX / size.width) > 0.5 ? 1.0 : 0.0
            let scale = size.width / coordinator.rect.width
            
            let offsetX = animateView ? (anchorX > 0.5 ? 15 : -15) * scale : 0
            let offsetY = animateView ? -coordinator.rect.minY * scale : 0
            
            if let image = coordinator.animationLayer, let post = coordinator.selectedItem  {
                Image(uiImage: image)
                    .scaleEffect(animateView ? scale : 1, anchor: .init(x: anchorX, y: 0))
                    .offset(x: offsetX, y: offsetY)
                    .onTapGesture {
                        // For Testing
                        coordinator.animationLayer = nil
                        coordinator.hideRootView = false
                        coordinator.hideLayer = false
                    }
                
                /// Hero Kinda View
                ImageView(post: post)
                    .allowsHitTesting(false)
                    .frame(
                        width: animateView ? size.width : rect.width,
                        height: animateView ? rect.height * scale : rect.height
                    )
                    .clipShape(.rect(cornerRadius: animateView ? 0 : 10))
                    .offset(x: animateView ? 0 : rect.minX, y:  animateView ? 0 : rect.minY)
            }
        }
        .ignoresSafeArea()  
    }
}

#Preview {
    ContentView  ()
}
