//
// SwiftUIView.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/23/24
// mjn2max.github.io 😜
// 
// Copyright © 2024. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

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

extension View {
    @ViewBuilder
    func borderView() -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 5, x: 3, y: 3)
            .shadow(color: .black.opacity(0.1), radius: 5, x: -3, y: -3)
    }
}
