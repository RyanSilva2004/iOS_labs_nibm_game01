import SwiftUI

struct CellView: View {
    var cell: GridCell
    var isPreviewVisible: Bool
    var isBombClicked: Bool  // Whether the cell was clicked as a bomb

    var body: some View {
        ZStack {
            Rectangle()
                .fill(isPreviewVisible || cell.isMatched || cell.isSelected ? (cell.color ?? Color.gray) : Color.gray)
                .aspectRatio(1, contentMode: .fit)

            // Show "💣" for bomb cells during the preview or when clicked
            if (isPreviewVisible || isBombClicked) && cell.color == nil {
                Text("💣")
                    .font(.largeTitle)
            }
        }
    }
}
