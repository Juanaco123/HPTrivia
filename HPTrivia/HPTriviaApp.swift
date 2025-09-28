//
//  HPTriviaApp.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI

@main
struct HPTriviaApp: App {
  private var game: Game = Game()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(game)
        }
    }
}
