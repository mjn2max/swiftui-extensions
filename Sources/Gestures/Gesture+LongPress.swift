//
// Gesture+LongPress.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/27/25
// mjn2max.github.io 😜
// 
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - Gesture Extensions - Long Press

extension View {
    /// Adds a long press gesture with a default duration of 0.5 seconds.
    ///
    /// - Parameter action: A closure called when the long press gesture completes.
    /// - Returns: A view that triggers the action on long press.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hold Me")
    ///     .onLongPress {
    ///         print("Long pressed!")
    ///     }
    /// ```
    public func onLongPress(_ action: @escaping () -> Void) -> some View {
        self.onLongPressGesture(perform: action)
    }

    
    /// Adds a long press gesture that triggers haptic feedback when pressed.
    ///
    /// - Parameters:
    ///   - duration: The minimum duration for the long press.
    ///   - style: The `UIImpactFeedbackGenerator.FeedbackStyle` for the haptic (default: `.medium`).
    ///   - action: A closure called when the gesture completes.
    ///
    /// # Usage
    /// ```swift
    /// Text("Haptic Press")
    ///     .onLongPressHaptic {
    ///         print("Long pressed with haptic!")
    ///     }
    /// ```
    public func onLongPressHaptic(
        duration: Double = 0.5,
        style: UIImpactFeedbackGenerator.FeedbackStyle = .medium,
        action: @escaping () -> Void
    ) -> some View {
        self.onLongPressGesture(minimumDuration: duration) {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
            action()
        }
    }
    /// Adds a long press gesture with customizable duration and maximum allowed movement.
    ///
    /// - Parameters:
    ///   - duration: The minimum duration (in seconds) the user must hold the press.
    ///   - maximumDistance: The maximum movement allowed during the press before it cancels.
    ///   - action: A closure called when the gesture completes.
    ///
    /// # Usage
    /// ```swift
    /// Circle()
    ///     .fill(Color.blue)
    ///     .frame(width: 80, height: 80)
    ///     .onLongPress(duration: 1.0, maximumDistance: 10) {
    ///         print("Pressed for 1 second")
    ///     }
    /// ```
    public func onLongPress(
        duration: Double,
        maximumDistance: CGFloat = 10,
        action: @escaping () -> Void
    ) -> some View {
        self.onLongPressGesture(minimumDuration: duration,
                                maximumDistance: maximumDistance,
                                perform: action)
    }

    
    /// Adds a long press gesture with a state callback for press start and completion.
    ///
    /// - Parameters:
    ///   - duration: The minimum duration (in seconds) the user must hold the press.
    ///   - onPressingChanged: A closure called with `true` when press begins and `false` when released.
    ///   - onCompleted: A closure called when the press is held for the full duration.
    ///
    /// # Usage
    /// ```swift
    /// Rectangle()
    ///     .fill(Color.green)
    ///     .frame(width: 120, height: 60)
    ///     .onLongPressState(duration: 1.5) { isPressing in
    ///         print("Pressing: \(isPressing)")
    ///     } onCompleted: {
    ///         print("Completed long press")
    ///     }
    /// ```
    public func onLongPressState(
        duration: Double = 0.5,
        onPressingChanged: @escaping (Bool) -> Void,
        onCompleted: @escaping () -> Void
    ) -> some View {
        self.onLongPressGesture(minimumDuration: duration,
                                perform: onCompleted,
                                onPressingChanged: onPressingChanged)
    }
}

private struct LongPressScaleModifier: ViewModifier {
    let duration: Double
    let scale: CGFloat
    let action: () -> Void
    @GestureState private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(.spring(), value: isPressed)
            .gesture(
                LongPressGesture(minimumDuration: duration)
                    .updating($isPressed) { current, state, _ in
                        state = current
                    }
                    .onEnded { _ in
                        action()
                    }
            )
    }
}
