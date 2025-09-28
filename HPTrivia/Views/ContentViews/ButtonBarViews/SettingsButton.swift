//
//  SettingsButton.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct SettingsButton: View {
  @Binding var animateViewsIn: Bool
  @State private var showSettings: Bool = false
  
  let geo: GeometryProxy
  
  var body: some View {
    VStack {
      if animateViewsIn {
        Button {
          showSettings.toggle()
        } label: {
          Image(systemName: "gearshape.fill")
            .font(.largeTitle)
            .foregroundStyle(.white)
            .shadow(radius: 5.0)
        }
        .transition(.offset(x: geo.size.width / 4.0))
      }
    }
    .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
  }
}

#Preview {
  GeometryReader { geo in
    SettingsButton(animateViewsIn: .constant(true), geo: geo)
  }
}
