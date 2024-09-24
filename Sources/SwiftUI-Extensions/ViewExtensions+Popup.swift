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
