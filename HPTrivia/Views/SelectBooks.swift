//
//  SelectBooks.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

struct SelectBooks: View {
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ZStack {
      Image(.parchment)
        .resizable()
        .ignoresSafeArea()
        .background(.brown)
      
      VStack {
        Text("Which books would you like to see questions from?")
          .font(.title)
          .multilineTextAlignment(.center)
          .padding()
        
        ScrollView {
          LazyVGrid(columns: [GridItem(), GridItem()]) {
            
          }
        }
        
        Button("Done") {
          dismiss()
        }
        .font(.largeTitle)
        .padding()
        .buttonStyle(.borderedProminent)
        .tint(.brown.mix(with: .black, by: 0.2))
        .foregroundStyle(.white)
      }
      .foregroundStyle(.black)
    }
  }
}

#Preview {
  SelectBooks()
}
