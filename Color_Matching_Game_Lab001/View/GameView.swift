//
//  GameView.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    let gridSize: Int

    private let spacing: CGFloat = 10

    init(gridSize: Int) {
        _viewModel = StateObject(wrappedValue: GameViewModel(gridSize: gridSize))
        self.gridSize = gridSize
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Score: \(viewModel.score)")
                .font(.title)
                .bold()

            // Grid Layout
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridSize),
                spacing: spacing
            ) {
                ForEach(viewModel.grid.indices, id: \.self) { index in
                    let cell = viewModel.grid[index]
                    CellView(cell: cell)
                        .onTapGesture {
                            viewModel.selectCell(index)
                        }
                }
            }
            .padding()

            if viewModel.isGameOver() {
                Text("Game Over! 🎉")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }

            Button("Restart") {
                viewModel.startNewGame(gridSize: gridSize)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
