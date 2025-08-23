//
// View+Background.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 12/14/23
// mjn2max.github.io 😜
//
// Copyright © 2023. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - View Background Extensions

extension View {
    /// Sets a full-screen background color ignoring safe area edges.
    ///
    /// - Parameter color: The color to use for the background.
    /// - Returns: A view with a full-screen background color.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .background(withColor: .blue)
    /// ```
    func background(withColor color: Color) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color, ignoresSafeAreaEdges: .all)
    }


    /// Sets a full-screen background color with a specified opacity, ignoring safe area edges.
    ///
    /// - Parameters:
    ///   - color: The background color.
    ///   - opacity: The opacity of the color.
    /// - Returns: A view with a translucent full-screen background.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .background(withColor: .black, opacity: 0.5)
    /// ```
    func background(withColor color: Color, opacity: Double) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color.opacity(opacity), ignoresSafeAreaEdges: .all)
    }

    
    /// Conditionally disables the view and applies reduced opacity.
    ///
    /// - Parameters:
    ///   - opacity: The opacity to apply when the view is disabled.
    ///   - condition: A boolean indicating whether the view should be disabled.
    /// - Returns: A view that is optionally disabled and faded.
    ///
    /// # Usage
    /// ```swift
    /// Button("Tap Me")
    ///     .disable(withOpacity: 0.3, isDisabled)
    /// ```
    func disable(withOpacity opacity: Double, _ condition: Bool) -> some View {
        self.disabled(condition)
            .opacity(condition ? opacity : 1)
    }
}
