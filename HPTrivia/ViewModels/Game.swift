//
//  Game.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import SwiftUI
import Foundation

@Observable
class Game {
  var bookQuestions: BookQuestions = BookQuestions()
  
  var gameScore: Int = 0
  var questionScore: Int = 5
  var recentScores: [Int] = [0, 0, 0]
  
  var activeQuestions: [Question] = []
  var answeredQuestions: [Int] = []
  var currentQuestion: Question = try! JSONDecoder().decode([Question].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
  var answers: [String] = []
  
  func startGame() {
    for book in bookQuestions.books {
      if book.status == .active {
        for question in book.questions {
          activeQuestions.append(question)
        }
      }
    }
    
    newQuestion()
  }
  
  func newQuestion() {
    
  }
  
  func correct() {
    
  }
  
  func endGame() {
    recentScores[2] = recentScores[1]
    recentScores[1] = recentScores[0]
    recentScores[0] = gameScore
    
    gameScore = 0
    activeQuestions = []
    answeredQuestions = []
  }
}
