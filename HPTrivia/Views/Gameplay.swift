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
  @Namespace private var namespace
  @State private var musicPlayer: AVAudioPlayer!
  @State private var sfxPlayer: AVAudioPlayer!
  @State private var animateViewsIn: Bool = false
  @State private var revealHint: Bool = false
  @State private var revealBook: Bool = false
  @State private var tappedCorrectAnswer: Bool = false
  @State private var wrongAnswersTapped: [String] = []
  @State private var movePointsToScore: Bool = false
  
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
          
          VStack {
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
            .animation(.easeInOut(duration: animateViewsIn ? 2.0 : .zero), value: animateViewsIn)
            
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
              .animation(
                .easeOut(duration: animateViewsIn ? 1.5 : .zero)
                .delay(animateViewsIn ? 2.0 : .zero),
                value: animateViewsIn
              )
              
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
              .animation(
                .easeOut(duration: animateViewsIn ? 1.5 : .zero)
                .delay(animateViewsIn ? 2.0 : .zero),
                value: animateViewsIn
              )
            }
            .padding()
            
            //MARK: - Answers
            LazyVGrid(columns: [GridItem(), GridItem()]) {
              ForEach(game.answers, id: \.self) { answer in
                if answer == game.currentQuestion.answer {
                  VStack {
                    if animateViewsIn {
                      if !tappedCorrectAnswer {
                        Button {
                          withAnimation(.easeOut(duration: 1.0)) {
                            tappedCorrectAnswer.toggle()
                          }
                          playCorrectSound()
                          
                          DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            game.correct()
                          }
                          
                        } label: {
                          Text(answer)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: geo.size.width / 2.15, height: 80.0)
                            .background(.green.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .matchedGeometryEffect(id: 1, in: namespace)
                        }
                        .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 15.0).combined(with: .opacity)))
                      }
                    }
                  }
                  .animation(
                    .easeOut(duration: animateViewsIn ?  1.0 : .zero)
                    .delay(animateViewsIn ? 1.5 : .zero),
                    value: animateViewsIn
                  )
                } else {
                  VStack {
                    if animateViewsIn {
                      Button {
                        withAnimation(.easeOut(duration: 1.0)) {
                          wrongAnswersTapped.append(answer)
                        }
                        playWrongSound()
                        game.questionScore -= 1
                        
                      } label: {
                        Text(answer)
                          .minimumScaleFactor(0.5)
                          .multilineTextAlignment(.center)
                          .padding(10)
                          .frame(width: geo.size.width / 2.15, height: 80.0)
                          .background(wrongAnswersTapped.contains(answer) ? Color.red.opacity(0.5) : Color.green.opacity(0.5))
                          .clipShape(.rect(cornerRadius: 25))
                          .scaleEffect(wrongAnswersTapped.contains(answer) ? 0.8 : 1.0)
                      }
                      .transition(.scale)
                      .sensoryFeedback(.error, trigger: wrongAnswersTapped)
                      .disabled(wrongAnswersTapped.contains(answer))
                    }
                  }
                  .animation(
                    .easeOut(duration: animateViewsIn ?  1.0 : .zero)
                    .delay(animateViewsIn ? 1.5 : .zero),
                    value: animateViewsIn
                  )
                }
              }
            }
            
            Spacer()
          }
          .disabled(tappedCorrectAnswer)
          .opacity(tappedCorrectAnswer ? 0.1 : 1.0)
        }
        .frame(width: geo.size.width, height: geo.size.height)
        
        //MARK: - Celebration Screen
        VStack {
          Spacer()
          
          VStack {
            if tappedCorrectAnswer {
              Text("\(game.questionScore)")
                .font(.largeTitle)
                .padding(.top, 50)
                .transition(.offset(y: -geo.size.height / 4.0))
                .offset(
                  x: movePointsToScore ? geo.size.width / 2.3 : .zero,
                  y: movePointsToScore ? -geo.size.width / 13 : .zero
                )
                .opacity(movePointsToScore ? .zero : 1.0)
                .onAppear {
                  withAnimation(.easeInOut(duration: 1.0).delay(3.0)) {
                    movePointsToScore.toggle()
                  }
                }
            }
          }
          .animation(.easeInOut(duration: 1.0).delay(2.0), value: tappedCorrectAnswer)
          
          Spacer()
          
          VStack {
            if tappedCorrectAnswer {
              Text("Brilliant")
                .font(.custom("PartyLetPlain", size: 100))
                .transition(.scale.combined(with: .offset(y: -geo.size.height / 2.0)))
            }
          }
          .animation(
            .easeInOut(duration: tappedCorrectAnswer ? 1.0 : .zero)
            .delay(tappedCorrectAnswer ? 1.0 : .zero),
            value: tappedCorrectAnswer
          )
          .padding(.bottom, 28.0)
          
          Spacer()
          
          if tappedCorrectAnswer {
            Text(game.currentQuestion.answer)
              .minimumScaleFactor(0.5)
              .multilineTextAlignment(.center)
              .padding(10)
              .frame(width: geo.size.width / 2.15, height: 80)
              .background(.green.opacity(0.5))
              .clipShape(.rect(cornerRadius: 25))
              .scaleEffect(2.0)
              .matchedGeometryEffect(id: 1, in: namespace)
          }
          
          Spacer()
          Spacer()
          
          VStack {
            if tappedCorrectAnswer {
              Button("Next Level>") {
                resetValues()
                game.newQuestion()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                  animateViewsIn = true
                }
              }
              .font(.largeTitle)
              .buttonStyle(.borderedProminent)
              .tint(.blue.opacity(0.5))
              .transition(.offset(y: geo.size.height / 3))
              .phaseAnimator([false, true]) { content, phase in
                content
                  .scaleEffect(phase ? 1.2 : 1.0)
              } animation: { _ in
                  .easeInOut(duration: 1.3)
              }
            }
          }
          .animation(
            .easeInOut(duration:tappedCorrectAnswer ? 2.7 : .zero)
            .delay(tappedCorrectAnswer ? 2.7 : .zero),
            value: tappedCorrectAnswer
          )
          
          Spacer()
          Spacer()
        }
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
  
  private func resetValues() {
    animateViewsIn = false
    revealHint = false
    revealBook = false
    tappedCorrectAnswer = false
    wrongAnswersTapped = []
    movePointsToScore = false
  }
}

#Preview {
  Gameplay()
    .environment(Game())
}
