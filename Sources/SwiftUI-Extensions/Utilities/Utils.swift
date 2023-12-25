//
// SwiftUIView.swift
// 
//
// Created by Huy D. on 12/24/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

public struct Utils {
    // Find if the app is in Split View
    public static func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}
