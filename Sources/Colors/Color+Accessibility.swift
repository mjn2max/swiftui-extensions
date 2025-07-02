//
// Color+Accessibility.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/26/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

public extension Color {
    /// Determines an accessible foreground color (black or white) based on the current background color's brightness.
    ///
    /// On iOS, this method calculates brightness using the RGB components of the color and returns `.white` if the color is dark,
    /// or `.black` if the color is light. On unsupported platforms, it defaults to `.primary` for adaptability.
    ///
    /// - Returns: A `Color` (.black, .white, or .primary) suitable for readable foreground text.
    ///
    /// # Usage
    /// ```swift
    /// let background = Color.blue
    /// let foreground = background.accessibleTextColor()
    /// ```
    func accessibleTextColor() -> Color {
#if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil) {
            let brightness = (red * 299 + green * 587 + blue * 114) / 1000
            return brightness < 0.5 ? .white : .black
        }
#endif
        return .primary
    }


    /// Returns a version of the color with increased contrast by adjusting brightness slightly.
    /// Useful for ensuring UI elements stand out more clearly against their backgrounds.
    ///
    /// - Returns: A `Color` with slightly increased contrast (lighter or darker).
    ///
    /// # Usage
    /// ```swift
    /// let base = Color.gray
    /// let enhanced = base.highContrast()
    /// ```
    func highContrast() -> Color {
#if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let adjustment: CGFloat = 0.2
            let average = (red + green + blue) / 3
            let factor = average < 0.5 ? 1 + adjustment : 1 - adjustment
            let newColor = UIColor(red: min(red * factor, 1),
                                   green: min(green * factor, 1),
                                   blue: min(blue * factor, 1),
                                   alpha: alpha)
            return Color(newColor)
        }
#endif
        return self
    }


    /// Returns the inverted (complementary) color of the current color.
    /// Useful for creating visual contrast, hover states, or inverted themes.
    ///
    /// - Returns: A `Color` with each RGB component inverted.
    ///
    /// # Usage
    /// ```swift
    /// let original = Color.red
    /// let inverted = original.inverted()
    /// ```
    func inverted() -> Color {
    #if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let invertedColor = UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha)
            return Color(invertedColor)
        }
    #endif
        return self
    }
}
