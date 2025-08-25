//
// View+Popup.swift
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

/// This file provides SwiftUI view extensions for presenting popup alerts and navigation-based modals.
///
/// It includes:
/// - `showAlertWithTextField`: A UIKit-backed alert with a text field for user input.
/// - `popupNavigationView`: A SwiftUI-based modal overlay with a `NavigationView` for custom content.

/// Extension on `View` that provides custom popup and alert presentation helpers.
extension View {
#if os(iOS) || os(tvOS)
    /// Presents a UIKit alert with a text field from a SwiftUI view.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message displayed in the alert.
    ///   - hintText: The placeholder text for the text field.
    ///   - primaryTitle: The title of the primary action button.
    ///   - secondaryTitle: The title of the secondary (cancel) button.
    ///   - primaryAction: A closure called with the entered text when the primary button is tapped.
    ///   - secondaryAction: A closure called when the secondary button is tapped.
    ///
    /// # Usage
    /// ```
    /// Button("Present Alert") {
    ///     showAlertWithTextField(
    ///         title: "Login",
    ///         message: "Enter your password",
    ///         hintText: "123456",
    ///         primaryTitle: "Login",
    ///         secondaryTitle: "Cancel"
    ///     ) { input in
    ///         print(input)
    ///     } secondaryAction: {
    ///         print("Cancel")
    ///     }
    /// }
    /// ```
    func showAlertWithTextField(title: String, message: String, hintText: String,
                 primaryTitle: String, secondaryTitle: String,
                 primaryAction: @escaping (String) -> Void,
                 secondaryAction: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = hintText
        }
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
            } else {
                primaryAction("")
            }
        }))
        rootViewController.present(alert, animated: true)
    }
#endif


    /// Presents a custom popup containing a `NavigationView` overlay in the center of the screen.
    ///
    /// - Parameters:
    ///   - horizontalPadding: The horizontal padding applied to the popup's width.
    ///   - show: A binding to a Boolean that controls the popup's visibility.
    ///   - content: A closure returning the SwiftUI content displayed inside the popup.
    ///
    /// - Returns: A view that conditionally overlays a navigation popup on top of the existing view.
    ///
    /// # Usage
    /// ```
    /// @State private var showPopup = false
    ///
    /// var body: some View {
    ///     VStack {
    ///         Button("Show Popup") {
    ///             showPopup.toggle()
    ///         }
    ///     }
    ///     .popupNavigationView(show: $showPopup) {
    ///         Text("Popup Content")
    ///             .navigationTitle("Popup")
    ///     }
    /// }
    /// ```
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40,
                                            show: Binding<Bool>,
                                            @ViewBuilder content: @escaping () -> Content) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                if show.wrappedValue {
                    GeometryReader { geometry in
                        let geometrySize = geometry.size
                        Color.primary
                            .opacity(0.15)
                            .ignoresSafeArea()
                        NavigationView {
                            content()
                        }
                        .frame(width: geometrySize.width - horizontalPadding, height: geometrySize.height / 1.7, alignment: .center)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}
