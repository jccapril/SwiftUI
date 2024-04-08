//
//  FloatingButton.swift
//  InteractiveFloatingButton
//
//  Created by Jason on 2024/4/7.
//

import SwiftUI

/// Custom Button
struct FloatingButton<Label: View>: View {
    
    /// Actions
    var actions: [FloatingAction]
    var buttonSize: CGFloat
    var label: (Bool) -> Label
    
    init(buttonSize: CGFloat = 50, @FloatingActionBuilder actions: @escaping () -> [FloatingAction], label: @escaping (Bool) -> Label) {
        self.buttonSize = buttonSize
        self.actions = actions()
        self.label = label
    }
    
    /// View Properties
    @State private var isExpaned: Bool = false
    @State private var dragLocation: CGPoint = .zero
    @State private var selectedAction: FloatingAction?
    @GestureState private var isDragging: Bool = false
    var body: some View {
        Button(action: {
            isExpaned.toggle() 
        }, label: {
            label(isExpaned)
                .frame(width: buttonSize, height: buttonSize)
                .contentShape(.rect)
        })
        .buttonStyle(NoAnimationButtonStyle())
        .simultaneousGesture(longPressGesture)
        .background {
            ZStack {
                ForEach(actions) { action in
                    ActionView(action)
                }
            }
            .frame(width: buttonSize, height: buttonSize)
        }
        .coordinateSpace(.named("FLOATING VIEW"))
        .animation(.snappy(duration: 0.4, extraBounce: 0.0), value: isExpaned)
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.3)
            .onEnded { _ in
                isExpaned = true
            }.sequenced(before: DragGesture().updating($isDragging, body: { _, out, _ in
                out = true
            }).onChanged { value in
                guard isExpaned else { return }
                dragLocation = value.location
            }.onEnded{ _ in
                Task {
                    if let selectedAction {
                        isExpaned = false
                        selectedAction.action()
                    }
                    
                    selectedAction = nil
                    dragLocation = .zero
                }
            })
    }
    
    /// Action View
    @ViewBuilder
    func ActionView(_ action: FloatingAction) -> some View {
        Button(action: {
            action.action()
            isExpaned = false 
        }, label: {
            Image(systemName: action.symbol)
                .font(action.font)
                .foregroundStyle(action.tint)
                .frame(width: buttonSize, height: buttonSize)
                .background(action.background, in: .circle)
                .contentShape(.circle)
        })
        .buttonStyle(PressableButtonStyle())
        .disabled(!isExpaned)
        .animation(.snappy(duration: 0.3, extraBounce: 0.0)) { context in
            context
                .scaleEffect(selectedAction?.id == action.id ? 1.15 : 1)
        }
        .background {
            GeometryReader {
                let rect = $0.frame(in: .named("FLOATING VIEW"))
                
                Color.clear
                    .onChange(of: dragLocation) { oldValue, newValue in
                        if isExpaned && isDragging {
                            /// Checking if the drag location is inside any action's rect
                            if rect.contains(newValue) {
                                /// User is Pressing On  this Action
                                selectedAction = action
                            } else {
                                /// Checking if it's gone out of  the rect
                                if selectedAction?.id == action.id && !rect.contains(newValue) {
                                    selectedAction = nil
                                }
                            }
                        }
                    }
            }
        }
        .rotationEffect(.init(degrees: progress(action) * -90))
        .offset(x: isExpaned ? -offset/2 : 0)
        .rotationEffect(.init(degrees: progress(action) * 90))
    }
    
    private var offset: CGFloat {
        let buttonSize = buttonSize + 10
        return Double(actions.count) * (actions.count == 1 ? buttonSize * 2 : (actions.count == 2 ? buttonSize * 1.25 : buttonSize))
    }
    
    private func progress(_ action: FloatingAction) -> CGFloat {
        let index = CGFloat(actions.firstIndex(where: {
            $0.id == action.id
        }) ?? 0)
        return actions.count == 1 ? 1 : index/CGFloat(actions.count - 1)
    }
    


}
/// Custom Button Styles
fileprivate struct NoAnimationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

fileprivate struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.snappy(duration: 0.3, extraBounce: 0.0), value: configuration.isPressed )
    }
}

struct FloatingAction: Identifiable {
    private(set) var id: UUID = .init()
    var symbol: String
    var font: Font = .title3
    var tint: Color = .white
    var background: Color = .black
    var action: () -> ()
}

@resultBuilder
struct FloatingActionBuilder {
    static func buildBlock(_ components: FloatingAction...) -> [FloatingAction] {
        components.compactMap {
            $0
        }
    }
}

#Preview {
    ContentView()
}
