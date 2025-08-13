//
// ViewExtensions.swift
//
//
// Created by Huy D. on 12/14/23
// mjn2max.github.io 😜
//
// Copyright © 2023. All rights reserved.
// CodePassion.dev
//

import SwiftUI

// MARK: - Frame extensions
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

// MARK: - Background extensions
extension View {
    func background(withColor color: Color) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color, ignoresSafeAreaEdges: .all)
    }

    func background(withColor color: Color, opacity: Double) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color.opacity(opacity), ignoresSafeAreaEdges: .all)
    }

    func disable(withOpacity opacity: Double, _ condition: Bool) -> some View {
        self.disabled(condition)
            .opacity(condition ? opacity : 1)
    }
}

// MARK: - Rotation extensions
#if os(iOS) || os(tvOS)
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(RotationModifier(action: action))
    }
}

fileprivate struct RotationModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
#endif

/* Demo
struct ContentView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    var body: some View {
        VStack {
            switch orientation {
            case .faceDown:
                Text("Face Down")
            case .unknown:
                Text("unknown")
            case .portrait:
                Text("Portrait")
            case .portraitUpsideDown:
                Text("Portrait Upside Down")
            case .landscapeLeft:
                Text("Landscape Left")
            case .landscapeRight:
                Text("Landscape Right")
            case .faceUp:
                Text("Face Up")
            @unknown default:
                Text("unknown position")
            }
            Text("I am showing device orientation")
                .foregroundColor(.secondary)
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}
 */
