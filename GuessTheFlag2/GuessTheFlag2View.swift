//
//  ContentView.swift
//  GuessTheFlag2
//
//  Created by Zakee Tanksley on 7/7/25.
//
import SwiftUI

struct GuessTheFlag2View: View {
  @StateObject private var viewModel = GuessTheFlag2ViewModel()
  
  var body: some View {
    GeometryReader { geo in
      let isLandscape = geo.size.width > geo.size.height
      
      ZStack {
        RadialGradient(colors: [.white, .gray], center: .center, startRadius: 10, endRadius: 160)
          .ignoresSafeArea()
        
        VStack(spacing: 20) {
          Text(viewModel.options.isEmpty ? "???" : viewModel.options[viewModel.correctAnswer])
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.black)
            .padding(.top, 15)
          
          Group {
            if isLandscape {
              HStack(spacing: 30) {
                flagButtons
              }
            } else {
              VStack(spacing: 60) {
                flagButtons
              }
            }
          }
          
          Text("Tap the Correct Flag")
            .font(.footnote)
            .foregroundStyle(.regularMaterial)
            .padding(.bottom, 5)
        }
        .background(.ultraThinMaterial)
        .padding(.horizontal)
        
        if viewModel.showResult {
          Text(viewModel.resultMessage)
            .font(.title2)
            .padding()
            .background(.ultraThickMaterial)
            .cornerRadius(10)
            .transition(.scale)
            .zIndex(1)
        }
      }
    }
  }
  
  var flagButtons: some View {
    ForEach(viewModel.options.indices, id: \.self) { index in
      Button {
        viewModel.flagTapped(index: index)
      } label: {
        Image(viewModel.options[index])
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 100)
          .clipShape(.circle)
          .shadow(radius: 10)
      }
    }
  }
}




#Preview {
  GuessTheFlag2View()
}
