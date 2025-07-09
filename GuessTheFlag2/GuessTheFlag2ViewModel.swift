//
//  GuessGameViewModel.swift
//  GuessTheFlag2
//
//  Created by Zakee Tan on 7/9/25.
//
import Foundation
import SwiftUI

@MainActor
class GuessTheFlag2ViewModel: ObservableObject {
  private let countries = ["United Kingdom", "United States", "Monaco", "Ukraine", "Estonia","France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain"]
  
  @Published var options: [String] = []
  @Published var correctAnswer = 0
  @Published var resultMessage = ""
  @Published var showResult = false
  
  init() {
    generateFlags()
  }
  
  func generateFlags() {
    options = Array(countries.shuffled().prefix(3))
    correctAnswer = Int.random(in: 0..<options.count)
  }
  
  func flagTapped(index: Int) {
    if index == correctAnswer {
      resultMessage = "Correct: \(options[index])"
    } else {
      resultMessage = "Wrong: \(options[index])"
    }
    showResult = true
    
    Task {
      try? await Task.sleep(nanoseconds: 1_000_000_000)
      showResult = false
      generateFlags()
    }
  }
}
