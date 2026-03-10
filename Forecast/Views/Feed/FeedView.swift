import SwiftUI

struct FeedView: View {
    @EnvironmentObject private var viewModel: FeedViewModel
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var selectedArticle: Article? = nil
    @State private var flashCardsRemaining = MockData.flashCards.count

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.bg.ignoresSafeArea()

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {

                            // ── Flash section header ─────────────────────
                            let flashCurrent = min(MockData.flashCards.count - flashCardsRemaining + 1, MockData.flashCards.count)
                            HStack(spacing: 8) {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundStyle(.yellow)
                                Text("Daily Flash")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundStyle(AppTheme.textPrimary)
                                Text("· \(flashCurrent)/\(MockData.flashCards.count)")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundStyle(AppTheme.textSecondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.top, 20)
                            .padding(.bottom, 4)

                            // Flash Hero Block
                            FlashHeroView(
                                onReadArticle: { card in selectedArticle = article(for: card) },
                                cardsRemaining: $flashCardsRemaining
                            )

                            // ── Feed section header ───────────────────────
                            Text("Feed")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(AppTheme.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                                .padding(.top, 20)
                                .padding(.bottom, 4)

                            // Category tabs — anchored
                            CategoryTabsView(selected: $viewModel.selectedCategory) { _ in
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    proxy.scrollTo("categoryTabs", anchor: .top)
                                }
                            }
                            .id("categoryTabs")
                            .zIndex(1)

                            // Feed cards
                            ForEach(viewModel.filteredNews) { item in
                                FeedCardView(
                                    item: item,
                                    votedOptionId: viewModel.votedOptionId(for: item.id),
                                    article: viewModel.article(for: item),
                                    onVote: { option in viewModel.castVote(for: item.id, option: option) },
                                    onCardTap: { article in selectedArticle = article }
                                )
                            }

                            Color.clear.frame(height: 32) // bottom padding
                        }
                    }
                    .scrollIndicators(.hidden)
                    .onAppear { scrollProxy = proxy }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $selectedArticle) { article in
                ArticleView(article: article)
            }
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheetView(
                chosenOption: viewModel.heroChosenOption,
                topicTitle: viewModel.heroItem.title,
                isPresented: $viewModel.showShareSheet
            )
        }
    }

    // MARK: Flash Card → Article

    private func article(for card: FlashCard) -> Article {
        let category: Category = {
            switch card.category {
            case "Sports":   return .sports
            case "Tech":     return .tech
            case "Science":  return .science
            case "Politics": return .politics
            default:         return .finance
            }
        }()

        let ai = card.aiAnalysis
        let daPercent = ai.prosLabel == "ДА"
            ? Double(ai.confidencePercent)
            : Double(100 - ai.confidencePercent)

        // Use card.id as newsItem id so FeedViewModel tracks votes consistently
        let newsItem = NewsItem(
            id: card.id,
            title: card.question,
            subtitle: ai.pros.first ?? card.question,
            imageURL: card.imageURL,
            source: "Daily Flash",
            timeAgo: "сегодня",
            votesCount: card.votesCount,
            category: category,
            question: card.question,
            options: [
                VoteOption(iconName: "checkmark.circle.fill", text: "ДА",  subtitle: "", percent: daPercent),
                VoteOption(iconName: "xmark.circle.fill",    text: "НЕТ", subtitle: "", percent: 100 - daPercent)
            ],
            aiShortAnswer: card.aiShortAnswer,
            aiAnalysis: card.aiAnalysis
        )

        let body: [BodyElement] =
            ai.pros.map { .text(UUID(), $0) } +
            [.image(UUID(), card.imageURL, card.category)] +
            ai.cons.map { .text(UUID(), $0) }

        let keyFacts = [
            KeyFact(emoji: card.symbol,     text: card.category),
            KeyFact(emoji: "person.2.fill", text: "\(card.votesCount.formatted()) голосов"),
            KeyFact(emoji: "sparkles",      text: "AI: \(card.aiShortAnswer)")
        ]

        return Article(newsItem: newsItem, keyFacts: keyFacts, bodyParagraphs: body)
    }
}
