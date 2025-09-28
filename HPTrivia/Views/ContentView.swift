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
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        
        AnimatedBackground(geo: geo)
        
        VStack {
          
          GameTitle(animateViewsIn: $animateViewsIn)
          
          Spacer()
          
          RecentScores(animateViewsIn: $animateViewsIn)
          
          Spacer()
          
          ButtonBar(animateViewsIn: $animateViewsIn, geo: geo)
          
          Spacer()
        }
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .background(Color.indigo)
    }
    .ignoresSafeArea()
    .onAppear {
      animateViewsIn.toggle()
      //      playAudio()
    }
  }
  
  private func playAudio() {
    let infiniteLoop: Int = -1
    let audioTrackName: String = "magic-in-the-air"
    
    let sound = Bundle.main.path(forResource: audioTrackName, ofType: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    audioPlayer.numberOfLoops = infiniteLoop
    audioPlayer.play()
  }
}

#Preview {
  ContentView()
}
