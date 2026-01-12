//
//  GameView.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel

    init(rows: Int, columns: Int) {
        _viewModel = StateObject(wrappedValue: GameViewModel(rows: rows, columns: columns))
    }

    var body: some View {
        VStack {
            // Display the score
            Text("Score: \(viewModel.game.score)")
                .font(.title)
                .padding()

            GeometryReader { geometry in
                let gridWidth = geometry.size.width // Full screen width
                let buttonSpacing: CGFloat = 10
                let numColumns = viewModel.game.grid.first?.count ?? 3
                let buttonSize = (gridWidth - CGFloat(numColumns + 1) * buttonSpacing) / CGFloat(numColumns)

                VStack(spacing: buttonSpacing) {
                    ForEach(viewModel.game.grid.indices, id: \.self) { row in
                        HStack(spacing: buttonSpacing) {
                            ForEach(viewModel.game.grid[row].indices, id: \.self) { col in
                                let tile = viewModel.game.grid[row][col]

                                Button(action: {
                                    viewModel.selectTile(at: row, column: col)
                                }) {
                                    Rectangle()
                                        .fill(tile.isMatched ? Color.gray : tile.color)
                                        .frame(width: buttonSize, height: buttonSize)
                                        .cornerRadius(8)
                                }
                                .disabled(tile.isMatched) // Disable matched buttons
                            }
                        }
                    }
                }
                .frame(width: gridWidth)
            }
            .padding()

            Spacer()

            // New Game Button
            Button("New Game") {
                viewModel.generateGrid(rows: viewModel.game.grid.count, columns: viewModel.game.grid.first?.count ?? 3)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Game On!")
        .navigationBarTitleDisplayMode(.inline)
    }
}
