//
//  foodApp.swift
//  food
//
//  Created by Pala Rushil on 2/19/25.
//

import SwiftUI
import SwiftData

@main
struct foodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: FoodPost.self)
    }
}
