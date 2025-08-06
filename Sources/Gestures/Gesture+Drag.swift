//
// Gesture+Drag.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/27/25
// mjn2max.github.io 😜
//
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import SwiftUI

extension View {
    /// Adds a drag gesture that updates an offset binding.
    ///
    /// - Parameters:
    ///   - offset: A `Binding<CGSize>` to update as the view is dragged.
    ///   - minimumDistance: The minimum drag distance to begin the gesture.
    ///   - coordinateSpace: The coordinate space for the drag gesture.
    /// - Returns: A view with the drag gesture applied.
    ///
    /// # Usage
    /// ```swift
    /// @State private var offset: CGSize = .zero
    /// SomeView()
    ///     .draggable(offset: $offset)
    /// ```
    func draggable(
        offset: Binding<CGSize>,
        minimumDistance: CGFloat = 0,
        coordinateSpace: CoordinateSpace = .local
    ) -> some View {
        self.gesture(
            DragGesture(minimumDistance: minimumDistance)
                .onChanged { value in
                    offset.wrappedValue = value.translation
                }
                .onEnded { value in
                    offset.wrappedValue = value.translation
                },
            including: .all
        )
    }
}
