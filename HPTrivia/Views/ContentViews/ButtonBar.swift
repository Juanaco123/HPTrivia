//
//  ButtonBar.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct ButtonBar: View {
  @Binding var animateViewsIn: Bool
  @Binding var showPlayGame: Bool
  
  let geo: GeometryProxy
  
  var body: some View {
    HStack {
      Spacer()
      
      InstructionsButton(animateViewsIn: $animateViewsIn, geo: geo)
      
      Spacer()
      
      PlayButton(animateViewsIn: $animateViewsIn, showPlayGame: $showPlayGame, geo: geo)
      
      Spacer()
      
      SettingsButton(animateViewsIn: $animateViewsIn, geo: geo)
      
      Spacer()
    }
    .frame(width: geo.size.width)
  }
}

#Preview {
  GeometryReader { geo in
    ButtonBar(animateViewsIn: .constant(true), showPlayGame: .constant(false), geo: geo)

  }
}
