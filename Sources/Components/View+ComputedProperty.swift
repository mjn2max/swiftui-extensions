//
// SwiftUIView.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/23/24
// mjn2max.github.io 😜
//
// Copyright © 2024. All rights reserved.
// CodePassion.dev
//

#if canImport(UIKit)
import UIKit
#endif
import SwiftUI

#if os(iOS) || os(tvOS)
extension View {
    var screenBounds: CGRect {
        UIScreen.main.bounds
    }

    var screenSize: CGSize {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return scene.screen.bounds.size
    }

    var rootViewController: UIViewController {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = scene.windows.first?.rootViewController else {
            return .init()
        }
        return rootViewController
    }

    var safeAreaInsets: UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let safeAreaInsets = scene.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeAreaInsets
    }

    var isSplitScreen: Bool {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        return scene.windows.first?.frame.size != scene.screen.bounds.size
    }
}
#endif

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ logicValue: Bool, modifier: (Self) -> Content) -> some View {
        if logicValue {
            modifier(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func borderView() -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.1), radius: 5, x: -3, y: -3)
    }
}

/* Demo
struct ContentView: View {
    @State private var shouldAddShadow: Bool = true
    var body: some View {
        Text("Hi There!")
            .if(shouldAddShadow){ view in
                view.shadow(color: .black, radius: 5, x: 5.0, y: 5.0)
            }
    }
}
*/
