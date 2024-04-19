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

@Observable
class Toast {
    static let shared = Toast()
    fileprivate var toasts : [ToastItem] = []
    
    func present(title: String, symbol: String? = nil, tint: Color = .primary, isUserInteractionEnabled: Bool = false, duration: ToastDuration = .medium )  {
        toasts.append(.init(title: title, symbol: symbol, tint: tint, isUserInteractionEnabled: isUserInteractionEnabled, duration: duration))
    }
}

struct ToastItem: Identifiable {
    let id: UUID = .init()
    /// Custom Properties
    var title: String
    var symbol: String?
    var tint: Color
    var isUserInteractionEnabled: Bool
    
    /// Duration
    var duration: ToastDuration = .medium
}

enum ToastDuration: CGFloat {
    case short  = 1.0
    case medium = 2.0
    case long   = 3.5
}

fileprivate struct ToastGroup: View {
    var model = Toast.shared
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            ZStack {
                ForEach(model.toasts) {
                    ToastView(size: size, item: $0)
                }
            }
            .padding(.bottom, safeArea.top == .zero ? 15 : 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

fileprivate struct ToastView: View {
    var size: CGSize
    var item: ToastItem
    var body: some View {
        HStack(spacing: 10) {
            
            if let symbol = item.symbol {
                Image(systemName: symbol)
                    .font(.title3)
            }

            Text(item.title)
        }
        .foregroundStyle(item.tint)
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
        .background(
            .background
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
                .shadow(.drop(color: .primary.opacity(0.06), radius: 8, x: -5, y: -5)),
            in: .capsule
        )
        .contentShape(.capsule)
    }
}
