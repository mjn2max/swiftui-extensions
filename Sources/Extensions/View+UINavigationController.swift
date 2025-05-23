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

// MARK: - NavBar extensions
extension View {
    func setNavBarColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil, userInfo: [
                "color": color
            ])
        }
    }

    func setNavBarTitleColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil, userInfo: [
                "color": color,
                "forTitle": true
            ])
        }
    }

    func resetNavBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil)
        }
    }
}

#if os(iOS) || os(tvOS)
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNavBar(notification:)), name: .init(Constant.updateNavBar), object: nil)
    }

    @objc func updateNavBar(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            let appearance: UINavigationBarAppearance = .init()
            let transparentAppearance: UINavigationBarAppearance = .init()
            transparentAppearance.configureWithTransparentBackground()
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = transparentAppearance
            navigationBar.compactAppearance = appearance
            return
        }

        guard let color = userInfo["color"] as? Color else {
            return
        }

        if let _ = userInfo["forTitle"] {
            navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
            navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
            navigationBar.scrollEdgeAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
            navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor(color)]
            navigationBar.compactAppearance?.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
            navigationBar.compactAppearance?.titleTextAttributes = [.foregroundColor: UIColor(color)]
            return
        }

        if color == .clear {
            let transparentAppearance: UINavigationBarAppearance = .init()
            transparentAppearance.configureWithTransparentBackground()
            navigationBar.standardAppearance = transparentAppearance
            navigationBar.scrollEdgeAppearance = transparentAppearance
            navigationBar.compactAppearance = transparentAppearance
            return
        }

        let appearance: UINavigationBarAppearance = .init()
        appearance.backgroundColor = UIColor(color)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}
#endif
