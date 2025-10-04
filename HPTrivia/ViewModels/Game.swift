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
  
  let savePath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "RecentScores")
  
  init() {
    loadScores()
  }
  
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
    if answeredQuestions.count == activeQuestions.count {
      answeredQuestions = []
    }
    
    currentQuestion = activeQuestions.randomElement()!
    
    while(answeredQuestions.contains(currentQuestion.id)) {
      currentQuestion = activeQuestions.randomElement()!
    }
    
    answers = []
    
    answers.append(currentQuestion.answer)
    
    for answer in currentQuestion.wrong {
      answers.append(answer)
    }
    
    answers.shuffle()
    
    questionScore = 5
  }
  
  func correct() {
    answeredQuestions.append(currentQuestion.id)
    
    withAnimation {
      gameScore += questionScore
    }
  }
  
  func endGame() {
    recentScores[2] = recentScores[1]
    recentScores[1] = recentScores[0]
    recentScores[0] = gameScore
    
    saveScores()
    
    gameScore = 0
    activeQuestions = []
    answeredQuestions = []
  }
  
  func saveScores() {
    do {
      let data: Data = try JSONEncoder().encode(recentScores)
      try data.write(to: savePath)
    } catch {
      print("Unable to save data: \(error)")
    }
  }
  
  func loadScores() {
    do {
      let data: Data = try Data(contentsOf: savePath)
      recentScores = try JSONDecoder().decode([Int].self, from: data)
    } catch {
      recentScores = [0, 0, 0]
    }
  }
}
