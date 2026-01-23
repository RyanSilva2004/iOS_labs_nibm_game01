import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var grid: [GridCell] = []       // Grid representing the cells
    @Published var progress: Int = 0          // Matched pairs progress
    @Published var totalGroups: Int = 0       // Total groups needed to win
    @Published var lives: Int = 0             // Remaining lives
    @Published var isGameOver: Bool = false   // Track game-over state
    @Published var isPreviewVisible: Bool = true  // Control if grid shows preview state
    @Published var hasWon: Bool = false       // Track if the player has won
    @Published var showIncorrectAnimation: Bool = false // Show -1 animation on a wrong choice
    @Published var clickedBombIndex: Int? = nil // Track bomb cell that was clicked

    let gridSize: Int
    private let numberOfSelections: Int       // 2 for Easy, 3 for Medium/Hard
    private let primaryColors: [Color] = [.red, .green, .blue, .yellow]  // Primary colors for all levels
    private let secondaryColors: [Color] = [.orange, .cyan, .purple]     // Secondary colors for Medium/Hard levels
    private var selectedIndices: [Int] = []   // Tracks selected cells

    init(gridSize: Int) {
        self.gridSize = gridSize
        self.numberOfSelections = gridSize == 3 ? 2 : 3
        startNewGame()
    }

    func startNewGame() {
        progress = 0
        totalGroups = (gridSize * gridSize) / numberOfSelections   // Total groups required to win
        lives = gridSize == 3 ? 2 : gridSize == 5 ? 3 : 4         // Set lives based on level
        isGameOver = false
        hasWon = false
        isPreviewVisible = true
        showIncorrectAnimation = false
        clickedBombIndex = nil
        grid = []
        selectedIndices = []

        // Generate groups of matching cells and randomly distribute across the grid
        let groups = generateGroupsOfMatching()

        // Shuffle and fill the grid
        grid = groups.shuffled().map { GridCell(color: $0) }

        // Automatically hide the preview colors after the level-specific time limit
        let previewDuration = gridSize == 3 ? 3 : gridSize == 5 ? 5 : 8
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(previewDuration)) {
            self.isPreviewVisible = false
            
            // Reset all cells to their default state (hidden) after the preview
            self.grid.indices.forEach { self.grid[$0].isSelected = false }
        }
    }

    func generateGroupsOfMatching() -> [Color?] {
        var groups: [Color?] = []
        let totalCells = gridSize * gridSize

        // Create groups of matching cells
        var colorPalette: [Color] = primaryColors
        if gridSize > 3 {  // Add secondary colors for Medium/Hard grids
            colorPalette += secondaryColors
        }

        var colorIndex = 0
        while groups.count + numberOfSelections <= totalCells {
            groups.append(contentsOf: Array(repeating: colorPalette[colorIndex], count: numberOfSelections))
            colorIndex = (colorIndex + 1) % colorPalette.count  // Rotate colors
        }

        // Add bomb ("💣") cells to fill remaining spots
        while groups.count < totalCells {
            groups.append(nil)
        }

        return groups
    }

    func selectCell(_ index: Int) {
        // Do not allow clicks during the preview or if the game is over
        guard !isPreviewVisible, !isGameOver, !hasWon, !selectedIndices.contains(index) else { return }

        // Handle bomb cells
        if grid[index].color == nil {
            clickedBombIndex = index
            grid[index].isSelected = true  // Briefly show the bomb icon
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.isGameOver = true
            }
            return
        }

        // Mark the cell as selected
        selectedIndices.append(index)
        grid[index].isSelected = true

        // Once enough cells are selected, evaluate the selection
        if selectedIndices.count == numberOfSelections {
            evaluateSelection()
        }
    }

    private func evaluateSelection() {
        let selectedColors = selectedIndices.map { grid[$0].color }

        if selectedColors.allSatisfy({ $0 == selectedColors.first && $0 != nil }) {
            // Correct selection; mark cells as matched
            selectedIndices.forEach { grid[$0].isMatched = true }
            progress += 1
        } else {
            // Incorrect selection; lose a life
            lives -= 1
            showIncorrectAnimation = true

            // Temporarily show "-1 ❤️"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showIncorrectAnimation = false
            }

            if lives == 0 {
                isGameOver = true
            }
        }

        // Reset selection
        selectedIndices.forEach { grid[$0].isSelected = false }
        selectedIndices.removeAll()

        // Check if the player has won
        if progress == totalGroups {
            hasWon = true
        }
    }
}
