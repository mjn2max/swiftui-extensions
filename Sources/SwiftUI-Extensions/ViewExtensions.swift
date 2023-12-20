//
// ViewExtensions.swift
//
//
// Created by Huy D. on 12/14/23
// mjn2max.github.io 😜
//
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
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

// MARK: - NavBar extensions
extension View {
    func setNavBarColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: NSNotification.Name("UPDATENAVBAR"), object: nil, userInfo: [
                "color": color
            ])
        }
    }
    
    func resetNavBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: NSNotification.Name("UPDATENAVBAR"), object: nil)
        }
    }
    
    func setNavBarTitleColor(color: Color) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            NotificationCenter.default.post(name: NSNotification.Name("UPDATENAVBAR"), object: nil, userInfo: [
                "color": color,
                "forTitle": true
            ])
        }
    }
}
