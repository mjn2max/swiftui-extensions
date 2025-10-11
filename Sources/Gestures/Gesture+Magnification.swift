//
// Gesture+Magnification.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 6/27/25
// mjn2max.github.io 😜
// 
// Copyright © 2025. All rights reserved.
// CodePassion.dev
//

import Foundation
import SwiftUI

// MARK: - Gesture Extensions - Magnification (Pinch to Zoom)

extension View {
}

// MARK: - Internal Modifiers

/// A self‑contained pinch‑to‑zoom modifier that stores its own scale and clamps it.
private struct PinchToZoomModifier: ViewModifier {
    let minScale: CGFloat
    let maxScale: CGFloat
    let doubleTapToReset: Bool
    let onChanged: ((CGFloat) -> Void)?
    let onEnded: ((CGFloat) -> Void)?

    @State private var baseScale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0

    func body(content: Content) -> some View {
        let effectiveScale = baseScale * gestureScale

        return content
            .scaleEffect(effectiveScale)
            .animation(.spring(response: 0.25, dampingFraction: 0.9), value: gestureScale == 1 ? baseScale : effectiveScale)
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onChanged { _ in
                        onChanged?(clamp(effectiveScale))
                    }
                    .onEnded { value in
                        baseScale = clamp(baseScale * value)
                        onEnded?(baseScale)
                    }
            )
            .simultaneousGesture(
                doubleTapToReset
                ? TapGesture(count: 2).onEnded { baseScale = 1.0 }
                : nil
            )
    }

    private func clamp(_ s: CGFloat) -> CGFloat {
        min(max(s, minScale), maxScale)
    }
}
