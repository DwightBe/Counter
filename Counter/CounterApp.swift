//
//  visionDiceApp.swift
//  visionDice
//
//  Created by Dwight Benignus on 1/25/24.
//

import SwiftUI

@Observable
class Counter {
    var counter = 0
}

@main
struct CounterApp: App {
    @State var counter = Counter()
    
    var body: some Scene {

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
