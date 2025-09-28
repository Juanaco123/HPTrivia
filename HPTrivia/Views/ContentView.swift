//
//  ContentView.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import AVKit
import SwiftUI

struct ContentView: View {
  @State private var audioPlayer: AVAudioPlayer!
  @State private var animateViewsIn: Bool = false
  @State private var showPlayGame: Bool = false
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        
        AnimatedBackground(geo: geo)
        
        VStack {
          
          GameTitle(animateViewsIn: $animateViewsIn)
          
          Spacer()
          
          RecentScores(animateViewsIn: $animateViewsIn)
          
          Spacer()
          
          ButtonBar(animateViewsIn: $animateViewsIn, showPlayGame: $showPlayGame , geo: geo)
          
          Spacer()
        }
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .background(Color.indigo)
    }
    .ignoresSafeArea()
    .onAppear {
      animateViewsIn.toggle()
      playAudio()
    }
    .fullScreenCover(isPresented: $showPlayGame) {
      Gameplay()
        .onAppear {
          audioPlayer.setVolume(0, fadeDuration: 2)
        }
        .onDisappear {
          audioPlayer.setVolume(1, fadeDuration: 3)
        }
    }
  }
  
  private func playAudio() {
    let infiniteLoop: Int = -1
    let audioTrackName: String = "magic-in-the-air"
    
    let sound = Bundle.main.path(forResource: audioTrackName, ofType: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    audioPlayer.numberOfLoops = infiniteLoop
//    audioPlayer.play()
  }
}

#Preview {
  ContentView()
    .environment(Game())
}
