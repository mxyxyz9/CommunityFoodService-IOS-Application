//
//  ContentView.swift
//  food
//
//  Created by Pala Rushil on 2/19/25.
//

import SwiftUI

struct ContentView: View {
    // TODO: Add authentication state
    @State private var isAuthenticated = true
    
    var body: some View {
        Group {
            if isAuthenticated {
                MainTabView()
            } else {
                // TODO: Add authentication view
                Text("Sign In")
            }
        }
    }
}

#Preview {
    ContentView()
}
