//
//  GameTitle.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct GameTitle: View {
  @Binding var animateViewsIn: Bool
  
  var body: some View {
    VStack {
      if animateViewsIn {
        VStack {
          Image(systemName: "bolt.fill")
            .imageScale(.large)
            .font(.largeTitle)
          
          Text("HP")
            .font(.custom("PartyLetPlain", size: 70.0))
            .padding(.bottom, -20)
          
          Text("Trivia")
            .font(.custom("PartyLetPlain", size: 60.0))
        }
        .padding(.top, 70)
        .transition(.move(edge: .top))
      }
    }
    .animation(.easeOut(duration: 0.7).delay(2.0), value: animateViewsIn)
  }
}

#Preview {
  GameTitle(animateViewsIn: .constant(true))
}
