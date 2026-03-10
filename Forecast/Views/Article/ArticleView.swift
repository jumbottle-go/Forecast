import SwiftUI

struct ArticleView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var feedViewModel: FeedViewModel

    private var vm: ArticleViewModel { ArticleViewModel(article: article) }

    private var newsItem: NewsItem { vm.newsItem }
    private var votedOptionId: UUID? { feedViewModel.votedOptionId(for: newsItem.id) }
    private var isVoted: Bool { votedOptionId != nil }

    var body: some View {
        ZStack(alignment: .topLeading) {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Header image
                    AsyncImage(url: URL(string: newsItem.imageURL)) { phase in
                        switch phase {
                        case .success(let img): img.resizable().scaledToFill()
                        default: Rectangle().fill(AppTheme.card)
                        }
                    }
                    .frame(height: 200)
                    .clipped()

                    // Category + title + meta
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            Image(systemName: newsItem.category.symbol)
                                .font(.caption2.bold())
                            Text(newsItem.category.rawValue)
                                .font(.caption.bold())
                        }
                        .foregroundStyle(AppTheme.accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.accent.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                        Text(newsItem.title)
                            .font(.title2.bold())
                            .foregroundStyle(AppTheme.textPrimary)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)

                        HStack(spacing: 6) {
                            Text(newsItem.source)
                            Text("·")
                            Text(newsItem.timeAgo)
                        }
                        .font(.caption)
                        .foregroundStyle(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    // MARK: Body
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(vm.bodyParagraphs) { element in
                            switch element {
                            case .text(_, let content):
                                Text(content)
                                    .font(.subheadline)
                                    .foregroundStyle(AppTheme.textPrimary)
                                    .lineSpacing(5)

                            case .image(_, let url, let caption):
                                VStack(alignment: .leading, spacing: 6) {
                                    AsyncImage(url: URL(string: url)) { phase in
                                        switch phase {
                                        case .success(let img): img.resizable().scaledToFill()
                                        default: Rectangle().fill(AppTheme.border).frame(height: 160)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(AppTheme.border, lineWidth: 1)
                                    )

                                    Text(caption)
                                        .font(.caption)
                                        .foregroundStyle(AppTheme.textSecondary)
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    Color.clear.frame(height: 100) // space for sticky bar
                }
            }
            .scrollIndicators(.hidden)

            // Back button — pinned top-left
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 38, height: 38)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.leading, 16)
            .padding(.top, 8)
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            stickyVoteBar
        }
    }

    // MARK: Sticky Vote Bar

    @ViewBuilder
    private var stickyVoteBar: some View {
        if newsItem.options.count >= 2 {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(height: 0.5)

                VotingBlockView(
                    question: newsItem.question,
                    options: newsItem.options,
                    votesCount: newsItem.votesCount,
                    votedOptionId: votedOptionId
                ) { option in
                    feedViewModel.castVote(for: newsItem.id, option: option)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            NotificationCenter.default.post(name: NSNotification.Name("ArticleDismissedSwipe"), object: nil)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .background(.ultraThinMaterial)
        }
    }
}
