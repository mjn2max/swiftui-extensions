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
}
