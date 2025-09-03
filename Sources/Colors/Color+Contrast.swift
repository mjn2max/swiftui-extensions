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
}
