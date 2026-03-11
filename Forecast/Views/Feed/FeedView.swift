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
                                onReadArticle: { card in selectedArticle = viewModel.articles[card.id] },
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
        .task { viewModel.loadData() }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheetView(
                chosenOption: viewModel.heroChosenOption,
                topicTitle: viewModel.heroItem.title,
                isPresented: $viewModel.showShareSheet
            )
        }
    }

}
