//
//  PlayButton.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct PlayButton: View {
  @Binding var animateViewsIn: Bool
  @Binding var showPlayGame: Bool
  @State private var scalePlayButton: Bool = false
  
  let geo: GeometryProxy
  
  var body: some View {
    VStack {
      if animateViewsIn {
        Button {
          showPlayGame.toggle()
        } label: {
          Text("Play")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding(.vertical, 7)
            .padding(.horizontal, 50)
            .background(.brown)
            .clipShape(.rect(cornerRadius: 7.0))
            .shadow(radius: 5.0)
            .scaleEffect(scalePlayButton ? 1.2 : 1.0)
            .onAppear {
              withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                scalePlayButton.toggle()
              }
            }
        }
        .transition(.offset(y: geo.size.height / 3.0))
      }
    }
    .animation(.easeOut(duration: 0.7).delay(2.0), value: animateViewsIn)
  }
}

#Preview {
  GeometryReader { geo in
    PlayButton(animateViewsIn: .constant(true), showPlayGame: .constant(false), geo: geo)
  }
}
