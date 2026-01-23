import SwiftUI

struct GridCell: Identifiable {
    let id = UUID()
    var color: Color?  // Optional for bombs ("💣")
    var isMatched: Bool = false
    var isSelected: Bool = false
}
