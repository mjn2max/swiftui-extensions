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

import SwiftUI

// MARK: - Gesture Extensions - Magnification (Pinch to Zoom)

extension View {
    /// Adds a simple magnification handler that reports the *live* combined scale value.
    ///
    /// - Parameter onChanged: Called continuously with the current scale (1.0 = original).
    /// - Returns: A view that reports live magnification changes.
    ///
    /// # Usage
    /// ```swift
    /// Text("Pinch me")
    ///     .onMagnify { scale in
    ///         print("Scale:", scale)
    ///     }
    /// ```
    /// > sample result: Prints values like 1.00 → 1.35 → 2.10 while pinching.
    public func onMagnify(_ onChanged: @escaping (CGFloat) -> Void) -> some View {
        self.gesture(
            MagnificationGesture()
                .onChanged { scale in onChanged(scale) }
        )
    }

    /// Adds a magnification gesture with configurable callbacks for change & end.
    ///
    /// - Parameters:
    ///   - onChanged: Called continuously with the current scale.
    ///   - onEnded: Called once with the final scale when the gesture ends.
    /// - Returns: A view that reports magnification change and end events.
    ///
    /// # Usage
    /// ```swift
    /// Rectangle()
    ///     .fill(.blue)
    ///     .frame(width: 120, height: 120)
    ///     .onMagnify(onChanged: { s in
    ///         print("Live:", s)
    ///     }, onEnded: { s in
    ///         print("Final:", s)
    ///     })
    /// ```
    public func onMagnify(
        onChanged: @escaping (CGFloat) -> Void,
        onEnded: @escaping (CGFloat) -> Void
    ) -> some View {
        self.gesture(
            MagnificationGesture()
                .onChanged(onChanged)
                .onEnded(onEnded)
        )
    }

    /// Makes the view pinch‑to‑zoom with internal state and optional double‑tap‑to‑reset.
    ///
    /// - Parameters:
    ///   - minScale: Minimum allowed scale (default: `1.0`).
    ///   - maxScale: Maximum allowed scale (default: `4.0`).
    ///   - doubleTapToReset: If `true`, a double‑tap resets to 1.0 (default: `true`).
    ///   - onChanged: Optional callback receiving the *live* effective scale.
    ///   - onEnded: Optional callback receiving the final clamped scale.
    /// - Returns: A zoomable view with built‑in clamping and reset behavior.
    ///
    /// # Usage
    /// ```swift
    /// Image("photo")
    ///     .resizable()
    ///     .scaledToFit()
    ///     .pinchToZoom(minScale: 1, maxScale: 3)
    /// ```
    /// > sample result: Pinch to zoom up to 3×, double‑tap to reset back to 1×.
    public func pinchToZoom(
        minScale: CGFloat = 1.0,
        maxScale: CGFloat = 4.0,
        doubleTapToReset: Bool = true,
        onChanged: ((CGFloat) -> Void)? = nil,
        onEnded: ((CGFloat) -> Void)? = nil
    ) -> some View {
        modifier(
            PinchToZoomModifier(
                minScale: minScale,
                maxScale: maxScale,
                doubleTapToReset: doubleTapToReset,
                onChanged: onChanged,
                onEnded: onEnded
            )
        )
    }

    /// Makes the view pinch‑to‑zoom while binding the *persistent* scale to external state.
    ///
    /// - Parameters:
    ///   - scale: A binding to the persistent scale (e.g., `@State var scale: CGFloat`).
    ///   - minScale: Minimum allowed scale (default: `1.0`).
    ///   - maxScale: Maximum allowed scale (default: `4.0`).
    ///   - doubleTapToReset: If `true`, a double‑tap resets to 1.0 (default: `true`).
    /// - Returns: A zoomable view with its scale synchronized to the provided binding.
    ///
    /// # Usage
    /// ```swift
    /// struct ZoomDemo: View {
    ///     @State private var scale: CGFloat = 1
    ///
    ///     var body: some View {
    ///         VStack {
    ///             Text(String(format: "Scale: %.2f×", scale))
    ///             Image(systemName: "doc.richtext")
    ///                 .resizable()
    ///                 .frame(width: 120, height: 160)
    ///                 .pinchToZoom(scale: $scale, minScale: 1, maxScale: 5)
    ///         }
    ///     }
    /// }
    /// ```
    /// > sample result: The label updates live as you pinch; double‑tap resets back to 1×.
    public func pinchToZoom(
        scale: Binding<CGFloat>,
        minScale: CGFloat = 1.0,
        maxScale: CGFloat = 4.0,
        doubleTapToReset: Bool = true
    ) -> some View {
        modifier(
            PinchToZoomBindingModifier(
                scale: scale,
                minScale: minScale,
                maxScale: maxScale,
                doubleTapToReset: doubleTapToReset
            )
        )
    }
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

/// A pinch‑to‑zoom modifier that binds the persistent scale to external state.
private struct PinchToZoomBindingModifier: ViewModifier {
    @Binding var scale: CGFloat
    let minScale: CGFloat
    let maxScale: CGFloat
    let doubleTapToReset: Bool

    @GestureState private var gestureScale: CGFloat = 1.0

    func body(content: Content) -> some View {
        let effectiveScale = clamp(scale * gestureScale)

        return content
            .scaleEffect(effectiveScale)
            .animation(.spring(response: 0.25, dampingFraction: 0.9), value: gestureScale == 1 ? scale : effectiveScale)
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        scale = clamp(scale * value)
                    }
            )
            .simultaneousGesture(
                doubleTapToReset
                ? TapGesture(count: 2).onEnded { scale = 1.0 }
                : nil
            )
    }

    private func clamp(_ s: CGFloat) -> CGFloat {
        min(max(s, minScale), maxScale)
    }
}
