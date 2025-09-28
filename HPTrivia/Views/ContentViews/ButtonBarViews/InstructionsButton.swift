//
//  InstructionsButton.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct InstructionsButton: View {
  @Binding var animateViewsIn: Bool
  @State var showInstructions: Bool = false
  
  let geo: GeometryProxy
  
  var body: some View {
    VStack {
      if animateViewsIn {
        Button {
          showInstructions.toggle()
        } label: {
          Image(systemName: "info.circle.fill")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .shadow(radius: 5.0)
        }
        .transition(.offset(x: -geo.size.width / 4.0))
      }
    }
    .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
    .sheet(isPresented: $showInstructions) {
      Instructions()
    }
  }
}

#Preview {
  GeometryReader { geo in
    InstructionsButton(animateViewsIn: .constant(true), geo: geo)
  }
}
