//
// SwiftUIView.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/28/24
// mjn2max.github.io 😜
//
// Copyright © 2024. All rights reserved.
// CodePassion.dev
//

import SwiftUI

fileprivate struct OffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> Void) -> some View {
        self.overlay {
            GeometryReader { geometry in
                let minX = geometry.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }

    @ViewBuilder
    func offsetY(completion: @escaping (CGFloat) -> Void) -> some View {
        self.overlay {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .global).minY
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }

    @ViewBuilder
    func offsetX(coordinateSpace: String, completion: @escaping (CGFloat) -> Void) -> some View {
        self.overlay {
            GeometryReader { geometry in
                let minX = geometry.frame(in: .named(coordinateSpace)).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }

    @ViewBuilder
    func offsetY(coordinateSpace: String, completion: @escaping (CGFloat) -> Void) -> some View {
        self.overlay {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .named(coordinateSpace)).minY
                Color.clear
                    .preference(key: OffsetKey.self, value: minY)
                    .onPreferenceChange(OffsetKey.self) { value in
                        completion(value)
                    }
            }
        }
    }
}
