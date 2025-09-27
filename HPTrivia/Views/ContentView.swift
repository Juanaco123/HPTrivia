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
  @State private var scalePlayButton: Bool = false
  @State private var showInstructions: Bool = false
  @State private var showSettings: Bool = false
  @State private var showPlayGame: Bool = false
  
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
          .animation(.easeOut(duration: 0.7).delay(2.0), value: animateViewsIn)
          
          Spacer()
          
          VStack {
            if animateViewsIn {
              VStack {
                Text("Resent Scores")
                  .font(.title2)
                
                Text("33")
                Text("27")
                Text("15")
              }
              .font(.title3)
              .foregroundStyle(.white)
              .padding(.horizontal)
              .background(.black.opacity(0.7))
              .clipShape(.rect(cornerRadius:15.0))
              .transition(.opacity)
            }
          }
          .animation(.linear(duration: 1.0).delay(4.0), value: animateViewsIn)
          
          Spacer()
          
          HStack {
            Spacer()
            
            VStack {
              if animateViewsIn {
                Button {
                  showInstructions.toggle()
                } label: {
                  Image(systemName: "info.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .shadow(radius: 5.0)
                }
                .transition(.offset(x: -geo.size.width / 4.0))
              }
            }
            .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
            
            Spacer()
            
            VStack {
              if animateViewsIn {
                Button {
                  // TODO: Play a game
                  showPlayGame.toggle()
                } label: {
                  Text("Play")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 50)
                    .background(.brown)
                    .clipShape(.rect(cornerRadius: 7.0))
                    .shadow(radius: 5.0)
                    .scaleEffect(scalePlayButton ? 1.2 : 1.0)
                    .onAppear {
                      withAnimation(.easeInOut(duration: 1.3).repeatForever()) {
                        scalePlayButton.toggle()
                      }
                    }
                }
                .transition(.offset(y: geo.size.height / 3.0))
              }
            }
            .animation(.easeOut(duration: 0.7).delay(2.0), value: animateViewsIn)
            
            Spacer()
            
            VStack {
              if animateViewsIn {
                Button {
                  showSettings.toggle()
                } label: {
                  Image(systemName: "gearshape.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .shadow(radius: 5.0)
                }
                .transition(.offset(x: geo.size.width / 4.0))
              }
            }
            .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
            
            Spacer()
          }
          .frame(width: geo.size.width)
          
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
    .sheet(isPresented: $showInstructions) {
      Instructions()
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
