//
//  WWWExamples2020App.swift
//  WWWExamples2020
//
//  Created by GEORGE QUENTIN on 25/10/2020.
//

import SwiftUI

@main // main tells swift that this struct should be the starting point for our app
struct WWWExamples2020App: App {
    @StateObject private var store = SandwichStore(sandwiches: testData)
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
