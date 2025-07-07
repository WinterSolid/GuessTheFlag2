//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Zakee Tanksley on 7/7/25.
//

import SwiftUI

struct ContentView: View {
  var countries = ["Estonia","France","Germany","Ireland", "Italy","Monaco","Nigeria", "Poland", "Spain", "UK","Ukraine","US"]
  var correctAnswer = Int.random(in: 0...2)
  var body: some View {
    
    ZStack {
      Color.gray
        .ignoresSafeArea()
      VStack(spacing: 30) {
        VStack {
          Text(countries[correctAnswer])
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding()
          
          ForEach (0..<3) { number in
            Button{
              
            } label: {
              Image(countries[number])
            }.padding()
          }
          
          Text("Tap the Correct Flag")
            .font(.footnote).foregroundStyle(.white)
            .padding()
          
          
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
