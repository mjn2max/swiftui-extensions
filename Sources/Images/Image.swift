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

    /// Rotates the image by the specified number of degrees.
    /// - Parameter degrees: The angle in degrees to rotate the image.
    /// - Returns: The rotated image view.
    ///
    /// # Usage
    /// ```swift
    /// Image("arrow").rotated(45)
    /// ```
    func rotated(_ degrees: Double) -> some View {
        self
            .rotationEffect(.degrees(degrees))
    }

    /// Flips the image horizontally.
    /// - Returns: The image flipped horizontally.
    ///
    /// # Usage
    /// ```swift
    /// Image("photo").flippedHorizontally()
    /// ```
    func flippedHorizontally() -> some View {
        self
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }

    /// Flips the image vertically.
    /// - Returns: The image flipped vertically.
    ///
    /// # Usage
    /// ```swift
    /// Image("photo").flippedVertically()
    /// ```
    func flippedVertically() -> some View {
        self
            .scaleEffect(x: 1, y: -1, anchor: .center)
    }

    /// Adds a shadow to the image.
    /// - Parameters:
    ///   - color: The color of the shadow.
    ///   - radius: The blur radius of the shadow.
    ///   - x: The horizontal offset.
    ///   - y: The vertical offset.
    /// - Returns: The image with a shadow.
    ///
    /// # Usage
    /// ```swift
    /// Image("icon").shadowed(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
    /// ```
    func shadowed(color: Color = .black.opacity(0.15), radius: CGFloat = 4, x: CGFloat = 0, y: CGFloat = 2) -> some View {
        self
            .shadow(color: color, radius: radius, x: x, y: y)
    }

    /// Forces the image to render as a template for tinting with `foregroundStyle`.
    ///
    /// # Usage
    /// ```swift
    /// Image(systemName: "heart.fill").asTemplate().foregroundStyle(.red)
    /// ```
    func asTemplate() -> some View {
        self.renderingMode(.template)
    }

    /// Forces the image to render with its original colors, ignoring system tint.
    ///
    /// # Usage
    /// ```swift
    /// Image("logo").asOriginal()
    /// ```
    func asOriginal() -> some View {
        self.renderingMode(.original)
    }

    /// Applies a rounded rectangle stroke around the image.
    /// - Parameters:
    ///   - color: Stroke color.
    ///   - lineWidth: Stroke width. Default 1.
    ///   - cornerRadius: Corner radius. Default 8.
    /// - Returns: An image with a rounded rectangle border overlay.
    ///
    /// # Usage
    /// ```swift
    /// Image("thumb")
    ///     .resizedAndFitted(to: .init(width: 80, height: 80))
    ///     .roundedBorder(color: .secondary, lineWidth: 1, cornerRadius: 10)
    /// ```
    func roundedBorder(color: Color = .secondary, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 8) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(color, lineWidth: lineWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }

    /// Wraps the image with a background shape and optional padding.
    /// - Parameters:
    ///   - color: Background fill color.
    ///   - cornerRadius: Corner radius for background.
    ///   - padding: Optional padding inside the background.
    /// - Returns: The image with a rounded rectangle background.
    ///
    /// # Usage
    /// ```swift
    /// Image(systemName: "bolt.fill")
    ///     .resizable()
    ///     .scaledToFit()
    ///     .withBackground(.yellow.opacity(0.2), cornerRadius: 12, padding: 8)
    /// ```
    func withBackground(_ color: Color, cornerRadius: CGFloat = 10, padding: CGFloat? = nil) -> some View {
        let padded = padding
            .map { AnyView(self.padding($0)) } ?? AnyView(self)
        return padded
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(color)
            )
    }

    /// Adds padding around the image and applies a capsule/rounded background automatically.
    /// - Parameters:
    ///   - padding: Padding amount around the image.
    ///   - background: Background color.
    ///   - isCapsule: When true, uses `Capsule()`; otherwise uses rounded rectangle.
    ///   - cornerRadius: Corner radius when `isCapsule` is false.
    ///
    /// # Usage
    /// ```swift
    /// Image(systemName: "paperplane.fill")
    ///     .resizable()
    ///     .scaledToFit()
    ///     .paddedBackground(10, background: .blue.opacity(0.1), isCapsule: true)
    /// ```
    func paddedBackground(_ padding: CGFloat = 8, background: Color = .secondary.opacity(0.12), isCapsule: Bool = false, cornerRadius: CGFloat = 10) -> some View {
        self
            .padding(padding)
            .background(
                Group {
                    if isCapsule {
                        Capsule().fill(background)
                    } else {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(background)
                    }
                }
            )
    }

    /// Applies a gradient mask to the image to fade edges or create stylish reveals.
    /// - Parameter gradient: The gradient used as a mask.
    /// - Returns: The image masked by the provided gradient.
    ///
    /// # Usage
    /// ```swift
    /// Image("banner")
    ///     .resizable()
    ///     .scaledToFill()
    ///     .withGradientMask(LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom))
    /// ```
    func withGradientMask(_ gradient: some ShapeStyle) -> some View {
        self.mask(
            Rectangle().fill(gradient)
        )
    }
    /// Adds a small corner badge overlay (e.g., a checkmark or count) on the image.
    /// - Parameters:
    ///   - alignment: Corner alignment for the badge.
    ///   - content: The badge view builder.
    ///
    /// # Usage
    /// ```swift
    /// Image("item")
    ///     .resizedAndFitted(to: .init(width: 80, height: 80))
    ///     .withCornerBadge(alignment: .bottomTrailing) {
    ///         Text("3")
    ///             .font(.caption2).bold()
    ///             .padding(4)
    ///             .background(.ultraThinMaterial, in: Capsule())
    ///     }
    /// ```
    func withCornerBadge<Badge: View>(alignment: Alignment = .topTrailing, @ViewBuilder content: () -> Badge) -> some View {
        self
            .overlay(alignment: alignment) {
                content()
            }
    }
/// A view modifier that conditionally applies a fixed `frame(width:height:)` to its content.
///
/// Use this modifier when you want to size an image (or any view) only when a concrete
/// `CGSize` is provided. If `size` is `nil`, the modifier leaves the content's sizing
/// behavior unchanged.
///
/// - Parameter size: An optional `CGSize` specifying the target width and height. When non-nil,
///   the content is framed to `size.width` by `size.height`. When `nil`, no frame is applied.
fileprivate struct ConditionalFrameModifier: ViewModifier {
    let size: CGSize?

    func body(content: Content) -> some View {
        if let size = size {
            content.frame(width: size.width, height: size.height)
        } else {
            content
        }
    }
}
