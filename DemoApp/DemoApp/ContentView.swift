//
// ContentView.swift
// DemoApp
//
// Created by Huy D. on 12/12/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI
import SwiftUIExtensions

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 50, height: 50)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
