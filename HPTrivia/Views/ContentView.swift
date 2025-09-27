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
        Image(.hogwarts)
          .resizable()
          .frame(width: geo.size.width * 3, height: geo.size.height)
          .padding(.top, 3)
          .phaseAnimator([false, true]) { content, phase in
            content
              .offset(x: phase ? geo.size.width / 1.1 : -geo.size.width / 1.1)
          } animation: { _ in
              .linear(duration: 60)
          }
        
        VStack {
          VStack {
            if animateViewsIn {
              VStack {
                Image(systemName: "bolt.fill")
                  .imageScale(.large)
                  .font(.largeTitle)
                
                Text("HP")
                  .font(.custom("PartyLetPlain", size: 70.0))
                  .padding(.bottom, -20)
                
                Text("Trivia")
                  .font(.custom("PartyLetPlain", size: 60.0))
              }
              .padding(.top, 70)
              .transition(.move(edge: .top))
            }
          }
          .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
          Spacer()
        }
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .background(Color.indigo)
    }
    .ignoresSafeArea()
    .onAppear {
      animateViewsIn = true
//      playAudio()
    }
  }
  
  private func playAudio() {
    let infiniteLoop: Int = -1
    let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
    audioPlayer.numberOfLoops = infiniteLoop
    audioPlayer.play()
  }
}

#Preview {
  ContentView()
}
