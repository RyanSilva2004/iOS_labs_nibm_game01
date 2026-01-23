import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel

    init(gridSize: Int) {
        _viewModel = StateObject(wrappedValue: GameViewModel(gridSize: gridSize))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Show Progress
            Text("\(viewModel.progress)/\(viewModel.totalGroups) Pairs Matched")
                .font(.title)
                .bold()

            // Show Lives with Heart Emojis
            HStack {
                ForEach(0..<viewModel.lives, id: \.self) { _ in
                    Text("❤️")
                        .font(.title)
                }

                if viewModel.showIncorrectAnimation {
                    Text("-1")
                        .font(.title2)
                        .foregroundColor(.red)
                        .transition(.opacity)
                }
            }

            // Grid Layout
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: viewModel.gridSize),
                spacing: 4
            ) {
                ForEach(viewModel.grid.indices, id: \.self) { index in
                    let cell = viewModel.grid[index]
                    CellView(
                        cell: cell,
                        isPreviewVisible: viewModel.isPreviewVisible,
                        isBombClicked: viewModel.clickedBombIndex == index
                    )
                    .onTapGesture {
                        viewModel.selectCell(index)
                    }
                }
            }
            .padding()

            // End-Game Messages
            if viewModel.isGameOver {
                Text("Game Over! 💣")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            } else if viewModel.hasWon {
                Text("You Win! 🎉")
                    .font(.largeTitle)
                    .foregroundColor(.green)
            }

            Button("Restart") {
                viewModel.startNewGame()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
