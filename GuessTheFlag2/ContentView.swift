//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Zakee Tanksley on 7/7/25.
//

import SwiftUI

struct ContentView: View {
  var countries = ["United Kingdom","United States","Monaco","Ukraine","Estonia","France","Germany","Ireland", "Italy","Nigeria", "Poland", "Spain"]
  var correctAnswer = Int.random(in: 0...2)
  var flagButtons: some View {
    ForEach(0..<3) { number in
      Button {
      } label: {
        Image(countries[number])
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .shadow(radius: 10)
      }
      .padding(.vertical, 5)
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      let isLandscapeMode = geometry.size.width > geometry.size.height
      ZStack {
        Color.secondary
          .ignoresSafeArea()
        
        VStack(spacing: 20) {
          VStack {
            Text(countries[correctAnswer])
              .font(.headline)
              .fontWeight(.bold)
              .foregroundStyle(.white)
              .padding(.top,15)
            Group {
              if isLandscapeMode {
                HStack(spacing: 16) {
                  flagButtons
                }
              } else {
                VStack(spacing: 16) {
                  flagButtons
                }
              }
            }
            
            
            
            Text("Tap the Correct Flag")
              .font(.footnote)
              .foregroundStyle(.white)
              .padding(.bottom,5)
          }
          .padding(.horizontal)
        }
      }
    }
  }
}




#Preview {
  ContentView()
}

