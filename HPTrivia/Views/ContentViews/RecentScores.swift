//
//  RecentScores.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct RecentScores: View {
  @Environment(Game.self) private var game
  @Binding var animateViewsIn: Bool
  
  var body: some View {
    VStack {
      if animateViewsIn {
        VStack {
          Text("Resent Scores")
            .font(.title2)
          
          Text("\(game.recentScores[0])")
          Text("\(game.recentScores[1])")
          Text("\(game.recentScores[2])")
        }
        .font(.title3)
        .foregroundStyle(.white)
        .padding(.horizontal)
        .background(.black.opacity(0.7))
        .clipShape(.rect(cornerRadius:15.0))
        .transition(.opacity)
      }
    }
    .animation(.linear(duration: 1.0).delay(4.0), value: animateViewsIn)
  }
}

#Preview {
  RecentScores(animateViewsIn: .constant(true))
    .environment(Game())
}
