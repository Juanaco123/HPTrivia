//
//  Gameplay.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 28/09/25.
//

import AVKit
import SwiftUI
import Foundation

struct Gameplay: View {
  @Environment(Game.self) private var game
  @Environment(\.dismiss) private var dismiss
  @State private var musicPlayer: AVAudioPlayer!
  @State private var sfxPlayer: AVAudioPlayer!
  @State private var animateViewsIn: Bool = false
  @State private var revealHint: Bool = false
  @State private var revealBook: Bool = false
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        Image(.hogwarts)
          .resizable()
          .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
          .overlay {
            Rectangle()
              .foregroundStyle(.black.opacity(0.8))
          }
        
        VStack {
          //MARK: - Controls
          HStack {
            Button("End Game") {
              game.endGame()
              dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red.opacity(0.5))
            
            Spacer()
            
            Text("Score: \(game.gameScore)")
          }
          .padding()
          .padding(.vertical, 30)
          
          //MARK: - Questions
          VStack {
            if animateViewsIn {
              Text(game.currentQuestion.question)
                .font(.custom("PartyLetPlain", size: 50.0))
                .multilineTextAlignment(.center)
                .padding()
                .transition(.scale)
            }
          }
          .animation(.easeInOut(duration: 2.0), value: animateViewsIn)
          
          Spacer()
          //MARK: - Hints
          HStack {
            VStack {
              if animateViewsIn {
                Image(systemName: "questionmark.app.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100)
                  .foregroundStyle(.cyan)
                  .transition(.offset(x: -geo.size.width / 2.0  ))
                  .phaseAnimator([false, true]) { content, phase in
                    content.rotationEffect(.degrees(phase ? -13 : -17))
                  } animation: { _ in
                      .easeInOut(duration: 0.7)
                  }
                  .onTapGesture {
                    withAnimation(.easeOut(duration: 1.0)) {
                      revealHint = true
                    }
                    playFlipSound()
                    game.questionScore -= 1
                  }
                  .rotation3DEffect(.degrees(revealHint ? 1440 : .zero), axis: (x: 0, y: 1, z: 0))
                  .scaleEffect(revealHint ? 5 : 1)
                  .offset(x: revealHint ? geo.size.width / 2 : .zero)
                  .opacity(revealHint ? .zero : 1.0)
                  .overlay {
                    Text(game.currentQuestion.hint)
                      .padding(.leading, 20)
                      .minimumScaleFactor(0.5)
                      .multilineTextAlignment(.center)
                      .opacity(revealHint ? 1.0 : .zero)
                      .scaleEffect(revealHint ? 1.33 : 1.0)
                  }
              }
            }
            .animation(.easeOut(duration: 1.0).delay(2.0), value: animateViewsIn)
            
            Spacer()
            
            VStack {
              if animateViewsIn {
                Image(systemName: "app.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100)
                  .foregroundStyle(.cyan)
                  .overlay {
                    Image(systemName: "book.closed")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 50)
                      .foregroundStyle(.black)
                  }
                  .transition(.offset(x: geo.size.width / 2.0  ))
                  .phaseAnimator([false, true]) { content, phase in
                    content.rotationEffect(.degrees(phase ? 13 : 17))
                  } animation: { _ in
                      .easeInOut(duration: 0.7)
                  }
                  .onTapGesture {
                    withAnimation(.easeOut(duration: 1.0)) {
                      revealBook = true
                    }
                    playFlipSound()
                    game.questionScore -= 1
                  }
                  .rotation3DEffect(.degrees(revealBook ? -1440 : .zero), axis: (x: 0, y: 1, z: 0))
                  .scaleEffect(revealBook ? 5 : 1)
                  .offset(x: revealBook ? -geo.size.width / 2 : .zero)
                  .opacity(revealBook ? .zero : 1.0)
                  .overlay {
                    Image("hp\(game.currentQuestion.book)")
                      .resizable()
                      .scaledToFit()
                      .padding(.trailing, 20)
                      .opacity(revealBook ? 1.0 : .zero)
                      .scaleEffect(revealBook ? 1.33 : 1.0)
                  }
              }
            }
            .animation(.easeOut(duration: 1.0).delay(2.0), value: animateViewsIn)
          }
          .padding()
          
          //MARK: - Answers
          
          Spacer()
        }
        .frame(width: geo.size.width, height: geo.size.height)
        
        //MARK: - Celebration Screen
      }
      .foregroundStyle(.white)
      .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
    .onAppear {
      game.startGame()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        animateViewsIn = true
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //        playMusic()
      }
    }
  }
  
  private func playMusic() {
    let infiniteLoop: Int = -1
    let songs: [String] = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell"]
    let song: String = songs.randomElement()!
    
    let sound = Bundle.main.path(forResource: song, ofType: "mp3")
    musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    musicPlayer.numberOfLoops = infiniteLoop
    musicPlayer.volume = 0.1
    musicPlayer.play()
  }
  
  private func playFlipSound() {
    let audioTrackName: String = "page-flip"
    
    let sound = Bundle.main.path(forResource: audioTrackName, ofType: "mp3")
    sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    sfxPlayer.play()
  }
  
  private func playWrongSound() {
    let audioTrackName: String = "negative-beeps"
    
    let sound = Bundle.main.path(forResource: audioTrackName, ofType: "mp3")
    sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    sfxPlayer.play()
  }
  
  private func playCorrectSound() {
    let audioTrackName: String = "magic-wand"
    
    let sound = Bundle.main.path(forResource: audioTrackName, ofType: "mp3")
    sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    sfxPlayer.play()
  }
}

#Preview {
  Gameplay()
    .environment(Game())
}
