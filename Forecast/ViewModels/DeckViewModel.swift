import SwiftUI
import Combine

enum SwipeDirection {
    case left, right
}

final class DeckViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var isComplete: Bool = false
    @Published var showAIPanel: Bool = false
    @Published var votes: [UUID: SwipeDirection] = [:]

    let cards: [PredictionCard]

    init(cards: [PredictionCard]) {
        self.cards = cards
    }

    var totalCards: Int { cards.count }
    var progress: Int { currentIndex }

    var currentCard: PredictionCard? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }

    var visibleCards: [(index: Int, card: PredictionCard)] {
        let remaining = cards.dropFirst(currentIndex)
        return Array(remaining.prefix(3).enumerated().map { (index: $0.offset, card: $0.element) })
    }

    func swipe(direction: SwipeDirection) {
        guard let card = currentCard else { return }
        withAnimation(.easeOut(duration: 0.35)) {
            votes[card.id] = direction
            currentIndex += 1
            showAIPanel = false
        }
        if currentIndex >= cards.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                withAnimation { self?.isComplete = true }
            }
        }
    }

    func toggleAIPanel() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showAIPanel.toggle()
        }
    }
}
