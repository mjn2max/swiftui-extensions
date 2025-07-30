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


    /// Applies a fill with optional opacity and blend mode.
    ///
    /// - Parameters:
    ///   - color: The fill color.
    ///   - opacity: The opacity of the fill (default is 1.0).
    ///   - blendMode: The blend mode to apply (default is `.normal`).
    /// - Returns: A view with the shape filled using the given style.
    ///
    /// # Usage
    /// ```swift
    /// RoundedRectangle(cornerRadius: 10).styledFill(color: .green, opacity: 0.7, blendMode: .multiply)
    /// ```
    func styledFill(color: Color, opacity: Double = 1.0, blendMode: BlendMode = .normal) -> some View {
        self
            .fill(color)
            .opacity(opacity)
            .blendMode(blendMode)
    }


    /// Applies both a fill and stroke with custom styling.
    ///
    /// - Parameters:
    ///   - fillColor: The fill color.
    ///   - strokeColor: The stroke color.
    ///   - lineWidth: The width of the stroke.
    /// - Returns: A view with the shape filled and stroked.
    ///
    /// # Usage
    /// ```swift
    /// Capsule().styledFillAndStroke(fillColor: .white, strokeColor: .gray, lineWidth: 2)
    /// ```
    func styledFillAndStroke(fillColor: Color, strokeColor: Color, lineWidth: CGFloat = 1) -> some View {
        ZStack {
            self.fill(fillColor)
            self.stroke(strokeColor, lineWidth: lineWidth)
        }
    }


    /// Applies a gradient stroke with optional line width and dash pattern.
    ///
    /// - Parameters:
    ///   - gradient: The `LinearGradient` to use as the stroke.
    ///   - lineWidth: The width of the stroke.
    ///   - dash: Optional dash pattern.
    /// - Returns: A view with the shape stroked using a gradient.
    ///
    /// # Usage
    /// ```swift
    /// Capsule().gradientStroke(gradient: LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
    /// ```
    func gradientStroke(gradient: LinearGradient, lineWidth: CGFloat = 1, dash: [CGFloat] = []) -> some View {
        self
            .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, dash: dash))
    }
}
