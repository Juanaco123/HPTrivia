//
//  InactiveBook.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 28/09/25.
//

import SwiftUI
import Foundation

struct InactiveBook: View {
  @State var book: Book
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Image(book.image)
        .resizable()
        .scaledToFit()
        .shadow(radius: 7.0)
        .overlay {
          Rectangle().opacity(0.33)
        }
      
      Image(systemName: "circle")
        .font(.largeTitle)
        .imageScale(.large)
        .foregroundStyle(.green.opacity(0.5))
        .shadow(radius: 1.0)
        .padding(3)
    }
  }
}

#Preview {
  InactiveBook(book: BookQuestions().books[0])
}
