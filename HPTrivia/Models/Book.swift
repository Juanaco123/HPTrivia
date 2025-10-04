//
//  Book.swift
//  HPTrivia
//
//  Created by Juan Camilo Victoria Pacheco on 27/09/25.
//

import Foundation

struct Book: Codable, Identifiable {
  let id: Int
  let image: String
  let questions: [Question]
  var status: BookStatus
}

enum BookStatus: Codable {
  case active, inactive, locked
}
