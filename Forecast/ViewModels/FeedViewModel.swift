import SwiftUI
import Combine

final class FeedViewModel: ObservableObject {
    @Published var selectedCategory: Category = .forYou
    @Published var heroVotedOptionId: UUID? = nil
    @Published var showShareSheet: Bool = false
    @Published var cardVotes: [UUID: UUID] = [:]      // newsItemId → optionId
    @Published var heroChosenOption: VoteOption? = nil

    let heroItem: NewsItem = MockData.breakingHero
    let allNews: [NewsItem]  = MockData.allNews
    let articles: [UUID: Article] = MockData.articles

    var filteredNews: [NewsItem] {
        guard selectedCategory != .forYou else { return allNews }
        return allNews.filter { $0.category == selectedCategory }
    }

    func article(for newsItem: NewsItem) -> Article? {
        articles[newsItem.id]
    }

    func heroArticle() -> Article? {
        articles[heroItem.id]
    }

    // MARK: Voting

    func castHeroVote(option: VoteOption) {
        guard heroVotedOptionId == nil else { return }
        withAnimation(.easeOut(duration: 0.6)) {
            heroVotedOptionId = option.id
            heroChosenOption  = option
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.showShareSheet = true
        }
    }

    func castVote(for newsItemId: UUID, option: VoteOption) {
        guard cardVotes[newsItemId] == nil else { return }
        withAnimation(.easeOut(duration: 0.6)) {
            cardVotes[newsItemId] = option.id
        }
    }

    func votedOptionId(for newsItemId: UUID) -> UUID? {
        cardVotes[newsItemId]
    }

    func isVoted(for newsItemId: UUID) -> Bool {
        cardVotes[newsItemId] != nil
    }
}
