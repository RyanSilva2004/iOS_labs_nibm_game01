//
//  CellView.swift
//  Color_Matching_Game_Lab001
//
//  Created by COBSCCOMP242P-059 on 2026-01-12.
//

import SwiftUI

struct CellView: View {
    var cell: GridCell

    var body: some View {
        Rectangle()
            .fill(cell.isMatched ? Color.gray : cell.color)
            .opacity(cell.isSelected || cell.isMatched ? 1 : 0.5)
            .frame(height: 50)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            .animation(.easeInOut, value: cell.isSelected)
    }
}
