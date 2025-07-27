//
// File.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 7/27/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

extension Shape {
    /// Applies a stroke style with rounded corners and optional dash pattern.
    ///
    /// - Parameters:
    ///   - color: The stroke color.
    ///   - lineWidth: The width of the stroke.
    ///   - dash: Optional dash pattern.
    /// - Returns: A view with the shape stroked using the given style.
    ///
    /// # Usage
    /// ```swift
    /// Circle().styledStroke(color: .blue, lineWidth: 2, dash: [5])
    /// ```
    func styledStroke(color: Color, lineWidth: CGFloat = 1, dash: [CGFloat] = []) -> some View {
        self
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: dash))
            .foregroundColor(color)
    }
}
