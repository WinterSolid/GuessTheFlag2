//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Zakee Tanksley on 7/7/25.
//

import SwiftUI

import SwiftUI

struct GuessGameView: View {
  private let countries = ["United Kingdom","United States","Monaco","Ukraine","Estonia",
                           "France","Germany","Ireland","Italy","Nigeria","Poland","Spain"]
  
  @State private var options: [String] = []
  @State private var correctAnswer = 0
  //pop up alert
  @State private var resultMessage = ""
  @State private var showResult = false
  
  var body: some View {
    GeometryReader { geo in
      let isLandscape = geo.size.width > geo.size.height
      
      ZStack {
        Color.secondary.ignoresSafeArea()
        
        VStack(spacing: 20) {
          Text(options.isEmpty ? "???" : options[correctAnswer])
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.top, 15)
          
          Group {
            if isLandscape {
              HStack(spacing: 30) { flagButtons }
            } else {
              VStack(spacing: 30) { flagButtons }
            }
          }
          
          Text("Tap the Correct Flag")
            .font(.footnote)
            .foregroundStyle(.white)
            .padding(.bottom, 5)
        }
        .padding(.horizontal)
        
        if showResult {
          Text(resultMessage)
            .font(.title2)
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(10)
            .transition(.scale)
            .zIndex(1)
        }
      }
      .onAppear(perform: generateFlags)
    }
  }
  
  // Flag buttons
  var flagButtons: some View {
    ForEach(options.indices, id: \.self) { index in
      Button {
        if index == correctAnswer {
          resultMessage =  (" Correct: \(options[index])")
        } else {
          resultMessage = ("Wrong: \(options[index])")
        }
        showResult = true
        
        // Halt till results shown after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          showResult = false
          generateFlags() // new round
        }
      } label: {
        Image(options[index])
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .shadow(radius: 10)
      }
    }
  }
  
  // Generate unique flags
  func generateFlags() {
    options = Array(countries.shuffled().prefix(3))
    correctAnswer = Int.random(in: 0..<options.count)
  }
}




#Preview {
  GuessGameView()
}

