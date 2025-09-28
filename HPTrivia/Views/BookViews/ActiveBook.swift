//
//  ActiveBook.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 28/09/25.
//

import SwiftUI
import Foundation

struct ActiveBook: View {
  @State var book: Book
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Image(book.image)
        .resizable()
        .scaledToFit()
        .shadow(radius: 7.0)
      
      Image(systemName: "checkmark.circle.fill")
        .font(.largeTitle)
        .imageScale(.large)
        .foregroundStyle(.green)
        .shadow(radius: 3.0)
        .padding(3)
    }
  }
}

#Preview {
  ActiveBook(book: BookQuestions().books[0])
}
