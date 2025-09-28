//
//  LockedBook.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 28/09/25.
//

import SwiftUI
import Foundation

struct LockedBook: View {
  @State var book: Book
  
  var body: some View {
    ZStack {
      Image(book.image)
        .resizable()
        .scaledToFit()
        .shadow(radius: 7.0)
        .overlay {
          Rectangle().opacity(0.75)
        }
      
      Image(systemName: "lock.fill")
        .font(.largeTitle)
        .imageScale(.large)
        .shadow(color: .white, radius: 2.0)
    }
  }
}

#Preview {
  LockedBook(book: BookQuestions().books[0])
}
