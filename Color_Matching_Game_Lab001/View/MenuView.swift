//
//  ContentView.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-10.
//

// File: MainMenuView.swift
import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Color Basher")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                NavigationLink(destination: GameView(gridSize: 3)) {
                    Text("Easy")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                NavigationLink(destination: GameView(gridSize: 5)) {
                    Text("Medium")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                NavigationLink(destination: GameView(gridSize: 7)) {
                    Text("Hard")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}
