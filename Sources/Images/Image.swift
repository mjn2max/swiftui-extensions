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


    /// Applies a tint color to the image, optionally specifying a blend mode.
    ///
    /// Use this for template or monochrome assets where you want to colorize the image.
    /// If the image isn't a template, consider setting `.renderingMode(.template)` upstream.
    ///
    /// - Parameters:
    ///   - color: The tint color to apply.
    ///   - blendMode: The blend mode used to apply the tint (default is `.sourceAtop`).
    /// - Returns: A view with the tinted image.
    ///
    /// # Usage
    /// ```swift
    /// Image(systemName: "star.fill")
    ///     .resizable()
    ///     .tinted(.yellow)
    /// ```
    func tinted(_ color: Color, blendMode: BlendMode = .sourceAtop) -> some View {
        self
            .renderingMode(.template)
            .foregroundStyle(color)
            .blendMode(blendMode)
    }
    
    
    /// Applies a grayscale effect to the image.
    /// - Parameter amount: The intensity of the grayscale effect (0 = original, 1 = grayscale).
    /// - Returns: A view with the grayscale effect applied.
    ///
    /// # Usage
    /// ```swift
    /// Image("photo").grayscaled(0.7)
    /// ```
    func grayscaled(_ amount: Double = 1.0) -> some View {
        self
            .saturation(1 - amount)
    }

    /// Blurs the image by a specified radius.
    /// - Parameter radius: The blur radius in points.
    /// - Returns: A blurred image view.
    ///
    /// # Usage
    /// ```swift
    /// Image("photo").blurred(radius: 5)
    /// ```
    func blurred(radius: CGFloat) -> some View {
        self
            .blur(radius: radius)
    }

    /// Applies rounded corners to the image with a given radius.
    /// - Parameter radius: The radius of the rounded corners.
    /// - Returns: The image clipped with rounded corners.
    ///
    /// # Usage
    /// ```swift
    /// Image("avatar").cornered(12)
    /// ```
    func cornered(_ radius: CGFloat) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
    /// A view modifier that conditionally applies a fixed `frame(width:height:)` to its content.
    ///
    /// Use this modifier when you want to size an image (or any view) only when a concrete
    /// `CGSize` is provided. If `size` is `nil`, the modifier leaves the content's sizing
    /// behavior unchanged.
    ///
    /// - Parameter size: An optional `CGSize` specifying the target width and height. When non-nil,
    ///   the content is framed to `size.width` by `size.height`. When `nil`, no frame is applied.
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
