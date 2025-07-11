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

// MARK: - Color Extensions - Accessibility

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


    /// Blends the current color with another color by a given ratio.
    ///
    /// - Parameters:
    ///   - color: The color to blend with.
    ///   - ratio: The ratio (0.0–1.0) of the second color in the blend.
    /// - Returns: A new `Color` representing the blend.
    ///
    /// # Usage
    /// ```swift
    /// let blended = Color.red.blended(with: .blue, ratio: 0.5)
    /// ```
    func blended(with color: Color, ratio: CGFloat) -> Color {
#if os(iOS)
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 1
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 1

        UIColor(self).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        UIColor(color).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let clampedRatio = max(0, min(1, ratio))
        let newRed = r1 * (1 - clampedRatio) + r2 * clampedRatio
        let newGreen = g1 * (1 - clampedRatio) + g2 * clampedRatio
        let newBlue = b1 * (1 - clampedRatio) + b2 * clampedRatio
        let newAlpha = a1 * (1 - clampedRatio) + a2 * clampedRatio

        return Color(UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha))
#else
        return self
#endif
    }


    /// Returns a new color by rotating the hue by a given angle (in degrees).
    ///
    /// - Parameter degrees: The amount to rotate the hue.
    /// - Returns: A new `Color` with adjusted hue.
    ///
    /// # Usage
    /// ```swift
    /// let shifted = Color.red.hueRotated(by: 180)
    /// ```
    func hueRotated(by degrees: CGFloat) -> Color {
#if os(iOS)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 1
        if UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newHue = fmod(hue + degrees / 360.0, 1.0)
            let adjustedHue = newHue < 0 ? newHue + 1.0 : newHue
            return Color(hue: adjustedHue, saturation: saturation, brightness: brightness, opacity: alpha)
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


// MARK: - Color Extensions - Return `CGFloat`

extension Color {
    /// Computes the relative luminosity difference between two colors based on WCAG guidelines.
    ///
    /// - Parameter other: The color to compare with.
    /// - Returns: A `CGFloat` representing the contrast ratio (1.0–21.0).
    ///
    /// # Usage
    /// ```swift
    /// let ratio = Color.black.contrastRatio(with: .white) // 21.0
    /// ```
    func contrastRatio(with other: Color) -> CGFloat {
#if os(iOS)
        func luminance(for color: UIColor) -> CGFloat {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 1
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            func adjust(_ component: CGFloat) -> CGFloat {
                return component <= 0.03928 ? component / 12.92 : pow((component + 0.055) / 1.055, 2.4)
            }
            let rl = adjust(r)
            let gl = adjust(g)
            let bl = adjust(b)
            return 0.2126 * rl + 0.7152 * gl + 0.0722 * bl
        }

        let l1 = luminance(for: UIColor(self))
        let l2 = luminance(for: UIColor(other))
        return (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05)
#else
        return 1.0
#endif
    }


    /// Returns the alpha (opacity) component of the color, if available.
    ///
    /// - Returns: A `CGFloat` between 0.0 (fully transparent) and 1.0 (fully opaque), or `1.0` by default.
    ///
    /// # Usage
    /// ```swift
    /// let alpha = Color.black.opacityValue()
    /// ```
    func opacityValue() -> CGFloat {
#if os(iOS)
        var alpha: CGFloat = 1.0
        UIColor(self).getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha
#else
        return 1.0
#endif
    }

    
    /// Calculates the color distance (Euclidean distance in RGB space) to another color.
    ///
    /// - Parameter other: The color to compare to.
    /// - Returns: A `CGFloat` representing the distance between two colors.
    ///
    /// # Usage
    /// ```swift
    /// let distance = Color.red.distance(to: .blue)
    /// ```
    func distance(to other: Color) -> CGFloat {
#if os(iOS)
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 1
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 1
        UIColor(self).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        UIColor(other).getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        let dr = r1 - r2
        let dg = g1 - g2
        let db = b1 - b2
        return sqrt(dr * dr + dg * dg + db * db)
#else
        return 0
#endif
    }
}
