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
}
