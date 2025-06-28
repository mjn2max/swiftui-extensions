//
// EnvironmentValues+Dragging.swift
// SwiftUI-Extensions
//
// Created by Huy D. on 9/28/24
// mjn2max.github.io 😜
// 
// Copyright © 2024. All rights reserved.
// CodePassion.dev
//

import SwiftUI

extension EnvironmentValues {
    /*
     USAGES:
     struct ContentView: View {
         @Environment(\.isDragging) var isDragging
         var body: some View {
             HomeView()
                 .environment(\.isDragging, gestureManager.isDragging)
         }
     }

     struct HomeView: View {
         @Environment(\.isDragging) var isDragging
         var body: some View {...}
     }
     */
    private struct UniversalGesture: EnvironmentKey {
        static let defaultValue: Bool = false
    }

    var isDragging: Bool {
        get {
            self[UniversalGesture.self]
        }
        set {
            self[UniversalGesture.self] = newValue
        }
    }

    /*
     USAGES:
     @main
     struct DemoApp: App {
         @Environment(\.safeArea) var safeArea
         var body: some Scene {
             WindowGroup {
                 GeometryReader(content: { geometry in
                     let safeArea = geometry.safeAreaInsets
                     ContentView()
                         .padding(safeArea)
                         .environment(\.safeArea, safeArea)
                         .ignoresSafeArea(.container, edges: .all)
                 })
             }
         }
     }

     struct HomeView: View {
         @Environment(\.safeArea) var safeArea
         var body: some View {...}
     }
     */
    struct SafeAreaValue: EnvironmentKey {
        static let defaultValue: EdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    }

    var safeArea: EdgeInsets {
        get {
            self[SafeAreaValue.self]
        }
        set {
            self[SafeAreaValue.self] = newValue
        }
    }
}
