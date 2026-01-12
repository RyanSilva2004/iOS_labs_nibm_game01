//
//  GameModel.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import Foundation
import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    var color: Color
    var isMatched: Bool = false // Tracks if the tile has been matched
}
