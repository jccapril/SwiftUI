//
//  Toast.swift
//  CustomToasts
//
//  Created by Jason on 2024/4/19.
//

import SwiftUI

/// Root View For Creating Overlay Windows
struct RootView<Content: View>: View {
    @ViewBuilder var content: Content
    /// View Properties
    @State private var overlayWindow: UIWindow?
    var body: some View {
         content
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                    let window = PassthroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    /// View Controller
                    let rootController = UIHostingController(rootView: ToastGroup())
                    rootController.view.frame = windowScene.keyWindow?.frame ?? .zero
                    rootController.view.backgroundColor = .clear
                    window.rootViewController = rootController
                    
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    window.tag = 1009
                      
                    overlayWindow = window
                }
            }
    }
}

/// 点击穿透
fileprivate class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
                
        return rootViewController?.view == view ? nil : view
    }
}

fileprivate struct ToastGroup: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ZStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
