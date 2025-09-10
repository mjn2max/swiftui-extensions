//
// Color+Contrast.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/26/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - Color Extensions - Contrast

extension Color {
    /// Determines if the color is considered light based on its relative luminance.
    ///
    /// - Returns: `true` if the color is light, `false` otherwise.
    ///
    /// # Usage
    /// ```swift
    /// let isWhiteLight = Color.white.isLight
    /// ```
    /// > sample result: `true`
    public var isLight: Bool {
        let components = UIColor(self).cgColor.components ?? [0,0,0]
        // Ensure at least RGB values
        let r = components.count >= 3 ? components[0] : components[0]
        let g = components.count >= 3 ? components[1] : components[0]
        let b = components.count >= 3 ? components[2] : components[0]

        // Relative luminance formula
        let luminance = (0.299 * r + 0.587 * g + 0.114 * b)
        return luminance > 0.5
    }


    /// Returns a contrasting color (`.black` or `.white`) for text, depending on the brightness of this color.
    ///
    /// - Returns: `.black` if the color is light, `.white` if the color is dark.
    ///
    /// # Usage
    /// ```swift
    /// let textColor = Color.blue.contrastingTextColor
    /// ```
    /// > sample result: `.white`
    public var contrastingTextColor: Color {
        return isLight ? .black : .white
    }


    /// The relative luminance of the color.
    ///
    /// - Returns: The luminance value as a `CGFloat` in the range [0, 1], where 0 is dark and 1 is light.
    ///
    /// # Usage
    /// ```swift
    /// let lum = Color.black.luminance
    /// ```
    /// > sample result: `0.0`
    public var luminance: CGFloat {
        let components = UIColor(self).cgColor.components ?? [0,0,0]
        let r = components.count >= 3 ? components[0] : components[0]
        let g = components.count >= 3 ? components[1] : components[0]
        let b = components.count >= 3 ? components[2] : components[0]
        return (0.299 * r + 0.587 * g + 0.114 * b)
    }


    /// Checks if the contrast ratio between this color and another color meets the WCAG AA minimum (4.5:1).
    ///
    /// - Parameter other: The other `Color` to compare contrast against.
    /// - Returns: `true` if the contrast ratio is at least 4.5, `false` otherwise.
    ///
    /// # Usage
    /// ```swift
    /// let hasContrast = Color.white.hasSufficientContrast(with: .gray)
    /// ```
    /// > sample result: `false`
    public func hasSufficientContrast(with other: Color) -> Bool {
        let l1 = luminance + 0.05
        let l2 = other.luminance + 0.05
        let ratio = l1 > l2 ? l1 / l2 : l2 / l1
        return ratio >= 4.5
    }


    /// Returns either black or white depending on which provides the better contrast with this color.
    ///
    /// - Returns: `.black` if black has a higher contrast ratio with this color, `.white` otherwise.
    ///
    /// # Usage
    /// ```swift
    /// let best = Color.red.bestContrastingColor
    /// ```
    /// > sample result: `.white`
    public var bestContrastingColor: Color {
        let contrastWithBlack = contrastRatio(with: .black)
        let contrastWithWhite = contrastRatio(with: .white)
        return contrastWithBlack > contrastWithWhite ? .black : .white
    }


    /// Adjusts the brightness of the color by a given factor.
    ///
    /// - Parameter amount: A value between -1.0 and 1.0. Negative values darken the color, positive values lighten it.
    /// - Returns: A new `Color` adjusted for brightness.
    ///
    /// # Usage
    /// ```swift
    /// let lighter = Color.blue.adjustBrightness(by: 0.2)
    /// ```
    /// > sample result: A lighter shade of blue
    public func adjustBrightness(by amount: CGFloat) -> Color {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let newBrightness = max(min(brightness + amount, 1.0), 0.0)
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(newBrightness))
    }
}
