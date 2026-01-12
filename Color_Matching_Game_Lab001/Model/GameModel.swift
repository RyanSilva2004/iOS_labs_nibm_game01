//
//  GameModel.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import Foundation
import SwiftUI

struct GameModel {
    var grid: [[Tile]] = [] // 2D array of tiles
    var score: Int = 0      // Player's current score

    mutating func shuffleGrid() {
        // Reshuffle all tiles that are not matched
        grid = grid.map { row in
            row.filter { !$0.isMatched }.shuffled()
        }
    }

    func hasAnyMovesAvailable() -> Bool {
        // Check if there are any matching tiles remaining, return true/false
        let flatGrid = grid.flatMap { $0 }
        for i in 0..<flatGrid.count {
            for j in (i+1)..<flatGrid.count {
                if flatGrid[i].color == flatGrid[j].color && !flatGrid[i].isMatched && !flatGrid[j].isMatched {
                    return true
                }
            }
        }
        return false
    }
}
