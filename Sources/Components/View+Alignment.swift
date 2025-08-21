//
// View+Alignment.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 12/14/23
// mjn2max.github.io 😜
//
// Copyright © 2023. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - View Alignments Extensions

extension View {
    /// Expands the view horizontally and aligns it to the leading edge.
    ///
    /// - Returns: A view with infinite horizontal width and leading alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .hLeading()
    /// ```
    public func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Expands the view horizontally and centers it.
    ///
    /// - Returns: A view with infinite horizontal width and centered alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .hCenter()
    /// ```
    public func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }

    /// Expands the view horizontally and aligns it to the trailing edge.
    ///
    /// - Returns: A view with infinite horizontal width and trailing alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .hTrailing()
    /// ```
    public func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    /// Expands the view vertically and aligns it to the top edge.
    ///
    /// - Returns: A view with infinite vertical height and top alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .vTop()
    /// ```
    public func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }

    /// Expands the view vertically and centers it.
    ///
    /// - Returns: A view with infinite vertical height and centered alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .vCenter()
    /// ```
    public func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }

    /// Expands the view vertically and aligns it to the bottom edge.
    ///
    /// - Returns: A view with infinite vertical height and bottom alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .vBottom()
    /// ```
    public func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
