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
        NavigationView {
            VStack(spacing: 20) {
                Text("Color Matching Game")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: GameView(rows: 3, columns: 3)) {
                    Text("Easy (3x3)").gameModeButtonStyle(backgroundColor: Color.green)
                }

                NavigationLink(destination: GameView(rows: 5, columns: 5)) {
                    Text("Medium (5x5)").gameModeButtonStyle(backgroundColor: Color.orange)
                }

                NavigationLink(destination: GameView(rows: 7, columns: 7)) {
                    Text("Hard (7x7)").gameModeButtonStyle(backgroundColor: Color.red)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

extension Text {
    func gameModeButtonStyle(backgroundColor: Color) -> some View {
        self
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 40)
    }
}
