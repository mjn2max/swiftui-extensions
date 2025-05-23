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

extension View {
#if os(iOS) || os(tvOS)
    /*
     USAGES:
     Button("Present Alert") {
         showAlertWithTextField(title: "Login", message: "Enter your password", hintText: "123456", primaryTitle: "Login", secondaryTitle: "Cancel") { username in
             print(username)
         } secondaryAction: {
             print("Cancel")
         }
     }
    */
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
