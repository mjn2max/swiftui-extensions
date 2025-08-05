//
// File.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 8/2/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - Image Extension

extension Image {
    /// Applies a standard resizing and rendering mode to the image.
    ///
    /// - Parameters:
    ///   - size: Optional size to frame the image.
    ///   - aspectRatio: Aspect ratio content mode (default is `.fit`).
    /// - Returns: A view-modified image.
    ///
    /// # Usage
    /// ```swift
    /// Image("icon").resizedAndFitted(to: CGSize(width: 100, height: 100))
    /// ```
    func resizedAndFitted(to size: CGSize? = nil, aspectRatio: ContentMode = .fit) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: aspectRatio)
            .modifier(ConditionalFrameModifier(size: size))
    }


    /// Applies a circular clipping mask to the image and optionally adds a border.
    ///
    /// - Parameters:
    ///   - borderColor: Optional color for the circular border.
    ///   - lineWidth: The width of the border line (default is 1).
    /// - Returns: A view with the image clipped to a circle and optionally bordered.
    ///
    /// # Usage
    /// ```swift
    /// Image("profile").circular(borderColor: .blue, lineWidth: 2)
    /// ```
    func circular(borderColor: Color? = nil, lineWidth: CGFloat = 1) -> some View {
        self
            .clipShape(Circle())
            .overlay {
                if let borderColor = borderColor {
                    Circle().stroke(borderColor, lineWidth: lineWidth)
                }
            }
    }

    
    private struct ConditionalFrameModifier: ViewModifier {
        let size: CGSize?

        func body(content: Content) -> some View {
            if let size = size {
                content.frame(width: size.width, height: size.height)
            } else {
                content
            }
        }
    }
}
