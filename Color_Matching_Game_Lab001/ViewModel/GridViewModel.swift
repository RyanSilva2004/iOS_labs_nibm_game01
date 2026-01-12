//
//  GridViewModel.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var grid: [GridCell] = []
    @Published var score: Int = 0

    private var selectedIndex: Int? = nil

    init(gridSize: Int) {
        startNewGame(gridSize: gridSize)
    }

    func startNewGame(gridSize: Int) {
        score = 0
        grid = []
        selectedIndex = nil

        // Generate random pairs of colors
        let colors = (0..<((gridSize * gridSize) / 2)).map { _ in
            Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )
        }

        // Create grid with duplicated and shuffled colors
        let allColors = (colors + colors).shuffled()
        grid = allColors.map { GridCell(color: $0) }
    }

    func selectCell(_ index: Int) {
        guard !grid[index].isMatched, !grid[index].isSelected else { return }

        grid[index].isSelected = true

        if let firstIndex = selectedIndex {
            // Check if selected cells match
            if grid[firstIndex].color == grid[index].color {
                grid[firstIndex].isMatched = true
                grid[index].isMatched = true
                score += 10
            } else {
                // Delay for feedback
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.grid[firstIndex].isSelected = false
                    self.grid[index].isSelected = false
                }
            }
            selectedIndex = nil
        } else {
            selectedIndex = index
        }
    }

    func isGameOver() -> Bool {
        return grid.allSatisfy { $0.isMatched }
    }
}
