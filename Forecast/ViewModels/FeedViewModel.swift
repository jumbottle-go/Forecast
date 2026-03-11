import SwiftUI
import Combine

// MARK: - UserDefaults cache for voted news item IDs

private enum VotedItemsCache {
    private static let key = "votedNewsItemIds"

    static func load() -> Set<UUID> {
        let strings = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(strings.compactMap { UUID(uuidString: $0) })
    }

    static func save(_ ids: Set<UUID>) {
        UserDefaults.standard.set(ids.map { $0.uuidString }, forKey: key)
    }

    static func add(_ id: UUID) {
        var current = load()
        current.insert(id)
        save(current)
    }
}

// MARK: - FeedViewModel

final class FeedViewModel: ObservableObject {
    @Published var selectedCategory: Category = .forYou
    @Published var heroVotedOptionId: UUID? = nil
    @Published var showShareSheet: Bool = false
    @Published var cardVotes: [UUID: UUID] = [:]      // newsItemId → optionId
    @Published var heroChosenOption: VoteOption? = nil
    @Published var allNews: [NewsItem] = []
    @Published var flashCards: [FlashCard] = []
    @Published var isLoading: Bool = false
    @Published var error: Error? = nil

    let heroItem: NewsItem = MockData.breakingHero
    let articles: [UUID: Article] = MockData.articles

    init() {}

    func loadData() {
        print("⏳ Загружаем данные...")
        Task {
            do {
                // 1. Ensure anonymous session exists
                try await SupabaseService.shared.ensureSignedIn()
                let userId = try SupabaseService.shared.currentUserId()
                print("👤 User ID: \(userId)")

                // 2. Download all news items
                let items = try await SupabaseService.shared.fetchNewsItems()
                print("✅ Скачано \(items.count) новостей из БД")

                // 3. Merge server-side voted IDs with local UserDefaults cache
                let serverVoted = try await SupabaseService.shared.fetchVotedNewsItemIds(userId: userId)
                let localVoted  = VotedItemsCache.load()
                let allVoted    = Set(serverVoted).union(localVoted)
                VotedItemsCache.save(allVoted)   // keep cache in sync with server
                print("🗳️ Уже проголосовано: \(allVoted.count)")

                // 4. Filter out already-voted items so user sees only fresh content
                let unseen    = items.filter { !allVoted.contains($0.id) }
                let feedItems = unseen.filter { !$0.isFlash }
                let cards     = unseen
                    .filter { $0.isFlash }
                    .compactMap { news -> FlashCard? in
                        guard let analysis = news.aiAnalysis else { return nil }
                        return FlashCard(
                            id: news.id,
                            question: news.question,
                            category: news.category.rawValue,
                            symbol: news.category.symbol,
                            imageURL: news.imageURL,
                            votesCount: news.votesCount,
                            aiShortAnswer: news.aiShortAnswer ?? "",
                            aiAnalysis: analysis
                        )
                    }

                print("📊 Лента: \(feedItems.count), Flash: \(cards.count)")
                await MainActor.run {
                    self.allNews    = feedItems
                    self.flashCards = cards
                    print("✅ UI обновлён — allNews: \(self.allNews.count), flashCards: \(self.flashCards.count)")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("❌ Ошибка декодирования (Data corrupted): \(context.debugDescription)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("❌ Ошибка декодирования (Key not found): '\(key.stringValue)' — \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("❌ Ошибка декодирования (Value not found): \(value) — \(context.debugDescription)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("❌ Ошибка декодирования (Type mismatch): \(type) — \(context.debugDescription)")
            } catch {
                print("❌ Неизвестная ошибка: \(error.localizedDescription)")
            }
        }
    }

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
        // Optimistic UI: update state immediately
        withAnimation(.easeOut(duration: 0.6)) {
            cardVotes[newsItemId] = option.id
        }
        // Persist to local cache instantly — next loadData will filter correctly
        // even if the network request hasn't completed yet
        VotedItemsCache.add(newsItemId)
        Task {
            do {
                try await SupabaseService.shared.saveVote(
                    newsItemId: newsItemId,
                    optionId: option.id.uuidString
                )
                print("✅ Голос успешно сохранен в БД")
            } catch {
                print("❌ Ошибка сохранения голоса: \(error.localizedDescription)")
            }
        }
    }

    func votedOptionId(for newsItemId: UUID) -> UUID? {
        cardVotes[newsItemId]
    }

    func isVoted(for newsItemId: UUID) -> Bool {
        cardVotes[newsItemId] != nil
    }
}
