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
    /// Fills the available width and aligns it to the leading edge.
    ///
    /// - Returns: A view with infinite horizontal width and leading alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignLeft()
    /// ```
    public func alignLeft() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }


    /// Fills the available width and centers it.
    ///
    /// - Returns: A view with infinite horizontal width and centered alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignHCenter()
    /// ```
    public func alignHCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }


    /// Fills the available width and aligns it to the trailing edge.
    ///
    /// - Returns: A view with infinite horizontal width and trailing alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignRight()
    /// ```
    public func alignRight() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }


    /// Fills the available height and aligns it to the top edge.
    ///
    /// - Returns: A view with infinite vertical height and top alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignTop()
    /// ```
    public func alignTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }


    /// Fills the available height and centers it.
    ///
    /// - Returns: A view with infinite vertical height and centered alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignVCenter()
    /// ```
    public func alignVCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }


    /// Fills the available height and aligns it to the bottom edge.
    ///
    /// - Returns: A view with infinite vertical height and bottom alignment.
    ///
    /// # Usage
    /// ```swift
    /// Text("Hello")
    ///     .alignBottom()
    /// ```
    public func alignBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}
