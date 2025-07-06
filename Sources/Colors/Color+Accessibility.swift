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

// MARK: - Color Extensions

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

    /// Returns a grayscale version of the current color.
    /// This is useful for accessibility adjustments or design purposes.
    ///
    /// - Returns: A grayscale `Color` based on the average brightness of the RGB components.
    ///
    /// # Usage
    /// ```swift
    /// let colored = Color.purple
    /// let gray = colored.grayscale()
    /// ```
    func grayscale() -> Color {
#if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let gray = (red + green + blue) / 3
            let grayColor = UIColor(red: gray, green: gray, blue: gray, alpha: alpha)
            return Color(grayColor)
        }
#endif
        return self
    }


    /// Returns a color that is either the current color or its inverted version, depending on contrast with a given background.
    /// This is useful for ensuring sufficient contrast between foreground and background elements.
    ///
    /// - Parameter background: The background color to evaluate contrast against.
    /// - Returns: A `Color` that provides better visual contrast against the given background.
    ///
    /// # Usage
    /// ```swift
    /// let textColor = Color.blue.adaptiveContrast(to: .white)
    /// ```
    func adaptiveContrast(to background: Color) -> Color {
#if os(iOS)
        var fgRed: CGFloat = 0, fgGreen: CGFloat = 0, fgBlue: CGFloat = 0, fgAlpha: CGFloat = 1
        var bgRed: CGFloat = 0, bgGreen: CGFloat = 0, bgBlue: CGFloat = 0, bgAlpha: CGFloat = 1

        let fgUIColor = UIColor(self)
        let bgUIColor = UIColor(background)

        if fgUIColor.getRed(&fgRed, green: &fgGreen, blue: &fgBlue, alpha: &fgAlpha),
           bgUIColor.getRed(&bgRed, green: &bgGreen, blue: &bgBlue, alpha: &bgAlpha) {

            let fgLuminance = (0.299 * fgRed + 0.587 * fgGreen + 0.114 * fgBlue)
            let bgLuminance = (0.299 * bgRed + 0.587 * bgGreen + 0.114 * bgBlue)

            let contrastRatio = (max(fgLuminance, bgLuminance) + 0.05) / (min(fgLuminance, bgLuminance) + 0.05)

            if contrastRatio < 4.5 {
                return self.inverted()
            }
        }
#endif
        return self
    }
}


// MARK: - Color Extensions - Return `Bool`

extension Color {
    /// Determines whether the color is considered light or dark based on perceived brightness.
    ///
    /// - Returns: `true` if the color is light, `false` if dark. Defaults to `nil` on unsupported platforms.
    ///
    /// # Usage
    /// ```swift
    /// if Color.yellow.isLightColor() {
    ///     // use dark foreground
    /// }
    /// ```
    func isLightColor() -> Bool {
#if os(iOS)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let brightness = (red * 299 + green * 587 + blue * 114) / 1000
            return brightness > 0.5
        }
#endif
        return false
    }
}
