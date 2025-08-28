//
// View+UINavigationController.swift
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
    /// Sets the navigation bar's background color.
    ///
    /// - Parameter color: The `Color` to apply to the navigation bar background.
    ///
    /// This method posts a notification that is observed by the custom `UINavigationController` extension,
    /// which updates the navigation bar appearance.
    func setNavBarColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil, userInfo: [
                "color": color
            ])
        }
    }

    /// Sets the navigation bar's title text color.
    ///
    /// - Parameter color: The `Color` to apply to the title text.
    ///
    /// This method posts a notification that is observed by the custom `UINavigationController` extension,
    /// which updates the title text attributes.
    func setNavBarTitleColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil, userInfo: [
                "color": color,
                "forTitle": true
            ])
        }
    }

    /// Resets the navigation bar to its default appearance.
    ///
    /// This method posts a notification that clears custom colors or attributes
    /// and restores the navigation bar to its transparent background state.
    func resetNavBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: .init(Constant.updateNavBar), object: nil)
        }
    }
}

#if os(iOS) || os(tvOS)
extension UINavigationController {
    /// Registers the navigation controller to observe appearance update notifications.
    ///
    /// When `Constant.updateNavBar` is posted, the controller updates its navigation bar appearance.
    open override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateNavBar(notification:)), name: .init(Constant.updateNavBar), object: nil)
    }

    /// Handles navigation bar updates based on the posted notification.
    ///
    /// - Parameter notification: A notification containing optional `userInfo`:
    ///   - `"color"`: A `Color` to apply either as a background or title color.
    ///   - `"forTitle"`: A Boolean flag (any value) indicating the color is for the title text.
    ///
    /// Depending on the parameters, this method updates the navigation bar background,
    /// title text attributes, or resets it to a transparent appearance.
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
