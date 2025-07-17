//
// Color+Brightness.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/26/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - Color Extensions - Brightness

extension Color {
    /// Returns the brightness of the color (from 0.0 to 1.0).
    ///
    /// # Usage
    /// ```swift
    /// let brightness = Color.orange.brightnessValue()
    /// ```
    func brightnessValue() -> CGFloat {
#if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red * 299 + green * 587 + blue * 114) / 1000
        }
#endif
        return 1.0 // default brightness
    }


    /// Clamps the brightness of the color within a specific range.
    ///
    /// - Parameters:
    ///   - minimum: The minimum brightness (0.0 to 1.0).
    ///   - maximum: The maximum brightness (0.0 to 1.0).
    /// - Returns: A `Color` adjusted to stay within the given brightness range.
    ///
    /// # Usage
    /// ```swift
    /// let adjusted = Color.blue.clampedBrightness(minimum: 0.3, maximum: 0.7)
    /// ```
    func clampedBrightness(minimum: CGFloat, maximum: CGFloat) -> Color {
#if os(iOS)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let clampedBrightness = min(max(brightness, minimum), maximum)
            return Color(hue: hue, saturation: saturation, brightness: clampedBrightness, opacity: alpha)
        }
#endif
        return self
    }


    /// Adjusts the brightness of the color by a given percentage.
    ///
    /// - Parameter percentage: The percentage to adjust brightness by (-1.0 to 1.0).
    /// - Returns: A new `Color` with brightness increased or decreased accordingly.
    ///
    /// # Usage
    /// ```swift
    /// let lighter = Color.red.adjustingBrightness(by: 0.2)
    /// let darker = Color.red.adjustingBrightness(by: -0.2)
    /// ```
    func adjustingBrightness(by percentage: CGFloat) -> Color {
#if os(iOS)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newBrightness = min(max(brightness + percentage, 0.0), 1.0)
            return Color(hue: hue, saturation: saturation, brightness: newBrightness, opacity: alpha)
        }
#endif
        return self
    }


    /// Returns a new color with the same brightness but reduced saturation.
    ///
    /// - Parameter amount: The amount to reduce saturation by (0.0–1.0).
    /// - Returns: A less saturated version of the color.
    ///
    /// # Usage
    /// ```swift
    /// let muted = Color.green.desaturated(by: 0.4)
    /// ```
    func desaturated(by amount: CGFloat) -> Color {
#if os(iOS)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newSaturation = max(saturation - amount, 0)
            return Color(hue: hue, saturation: newSaturation, brightness: brightness, opacity: alpha)
        }
#endif
        return self
    }

    
    /// Returns a grayscale version of the color, preserving brightness.
    ///
    /// - Returns: A new `Color` desaturated to grayscale.
    ///
    /// # Usage
    /// ```swift
    /// let gray = Color.purple.grayscalePreservingBrightness()
    /// ```
    func grayscalePreservingBrightness() -> Color {
#if os(iOS)
        var brightness: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getHue(nil, saturation: nil, brightness: &brightness, alpha: &alpha) {
            return Color(hue: 0.0, saturation: 0.0, brightness: brightness, opacity: alpha)
        }
#endif
        return self
    }
}
