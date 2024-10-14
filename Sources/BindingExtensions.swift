//
// SwiftUIView.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/28/24
// mjn2max.github.io 😜
// 
// Copyright © 2024. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
