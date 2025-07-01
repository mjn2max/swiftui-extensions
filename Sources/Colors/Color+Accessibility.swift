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
}
