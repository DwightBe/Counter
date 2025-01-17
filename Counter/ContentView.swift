//
//  ContentView.swift
//  visionDice
//
//  Created by Dwight Benignus on 1/25/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var counter: Counter
    
    var body: some View {
        VStack {
            Text("\(counter)")
                .foregroundStyle(.yellow)
                .font(.custom("Menlo",size: 100))
                .bold()
        }
        .task {
            await openImmersiveSpace(id: "ImmersiveSpace")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView(counter: Counter())
}
