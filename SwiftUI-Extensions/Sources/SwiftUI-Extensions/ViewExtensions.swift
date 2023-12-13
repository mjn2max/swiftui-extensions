//
// ViewExtensions.swift
//
//
// Created by Huy D. on 12/12/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

extension View {
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
}
