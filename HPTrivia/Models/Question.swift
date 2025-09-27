//
//  Question.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import Foundation

struct Question: Decodable {
  let id: Int
  let question: String
  let answer: String
  let wrong: [String]
  let book: Int
  let hint: String
}
