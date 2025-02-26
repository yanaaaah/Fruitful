//
//  FruitfullApp.swift
//  Fruitfull
//
//  Created by Yana Duran on 24/2/2025.
//

import SwiftUI

@main
struct FruitfullApp: App {
    @State private var dayDataStore = DayDataStore()
    
    var body: some Scene {
        WindowGroup {
//            TabView {
//                
//            }
//            .environment(dayDataStore)
            LoggingView()
                .environment(dayDataStore)
        }
    }
}
