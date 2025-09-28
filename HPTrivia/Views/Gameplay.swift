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
          
          //MARK: - Questions
          
          //MARK: - Hints
          
          //MARK: - Answers
        }
        .frame(width: geo.size.width, height: geo.size.height)
        
        //MARK: - Celebration Screen
      }
      .frame(width: geo.size.width, height: geo.size.height)
    }
    .ignoresSafeArea()
    .onAppear {
      game.startGame()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        playMusic()
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
