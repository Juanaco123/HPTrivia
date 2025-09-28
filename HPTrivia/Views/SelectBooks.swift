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
  @Environment(Game.self) private var game
  @State private var showTempAlert: Bool = false
  
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
            ForEach(game.bookQuestions.books) { book in
              if book.status == .active {
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
                .onTapGesture {
                  game.bookQuestions.changeStatus(of: book.id, to: .inactive)
                }
                
              } else if book.status == .inactive {
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
                .onTapGesture {
                  game.bookQuestions.changeStatus(of: book.id, to: .active)
                }
                
              } else {
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
                .onTapGesture {
                  showTempAlert.toggle()
                  game.bookQuestions.changeStatus(of: book.id, to: .active)
                }
              }
            }
          }
          .padding()
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
    .alert("You purchase a new question pack!", isPresented: $showTempAlert) {}
  }
}

#Preview {
  SelectBooks()
    .environment(Game())
}
