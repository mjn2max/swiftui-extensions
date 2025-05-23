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
    public func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    public func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }

    public func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    public func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }

    public func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }

    public func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
}

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
