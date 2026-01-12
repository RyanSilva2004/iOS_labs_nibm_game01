//
//  GridCell.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import SwiftUI

struct GridCell: Identifiable {
    let id = UUID()
    var color: Color
    var isMatched: Bool = false
    var isSelected: Bool = false
}
