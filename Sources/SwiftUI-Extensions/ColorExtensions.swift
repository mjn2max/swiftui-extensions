//
// SwiftUIView.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/23/24
// mjn2max.github.io 😜
// 
// Copyright © 2024. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

extension Color {
    var isDarkColor: Bool {
        UIColor(self).isDarkColor
    }
}

extension UIColor {
    var isDarkColor: Bool {
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return luminance < 0.5
    }

    var hexString: String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        return String(format: "#%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
    }
}
