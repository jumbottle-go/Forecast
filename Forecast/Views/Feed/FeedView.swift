import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var selectedArticle: Article? = nil
    private let tabsAnchor = "categoryTabs"

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.bg.ignoresSafeArea()

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {

                            // Hero
                            HeroCardView(
                                item: viewModel.heroItem,
                                votedOptionId: viewModel.heroVotedOptionId,
                                article: viewModel.heroArticle()
                            ) { option in
                                viewModel.castHeroVote(option: option)
                            }
                            .padding(.top, 12)

                            // Category tabs — anchored
                            CategoryTabsView(selected: $viewModel.selectedCategory) { _ in
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    proxy.scrollTo(tabsAnchor, anchor: .top)
                                }
                            }
                            .id(tabsAnchor)

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
            // Single navigation destination for the entire feed — no per-card destinations
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
}
