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

                    // MARK: Key Facts
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(vm.keyFacts) { fact in
                                HStack(spacing: 6) {
                                    Text(fact.emoji)
                                        .font(.body)
                                    Text(fact.text)
                                        .font(.caption)
                                        .foregroundStyle(AppTheme.textPrimary)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(AppTheme.card)
                                .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                                        .strokeBorder(AppTheme.border, lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                    }

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
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.subheadline.bold())
                    Text("Назад")
                        .font(.subheadline.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(.black.opacity(0.50))
                .clipShape(Capsule())
            }
            .padding(.leading, 16)
            .padding(.top, 56)
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
                // Top border
                Rectangle()
                    .fill(AppTheme.border)
                    .frame(height: 1)

                VStack(alignment: .leading, spacing: 10) {
                    // Question label
                    Text(newsItem.question)
                        .font(.subheadline.bold())
                        .foregroundStyle(AppTheme.textPrimary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    // Vote buttons
                    let colors: [Color] = [AppTheme.success, AppTheme.danger]
                    HStack(spacing: 8) {
                        ForEach(Array(newsItem.options.prefix(2).enumerated()), id: \.element.id) { idx, option in
                            VoteButton(
                                option: option,
                                isSelected: votedOptionId == option.id,
                                isVoted: isVoted,
                                showSubtitle: false,
                                tintColor: colors[idx]
                            ) {
                                feedViewModel.castVote(for: newsItem.id, option: option)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    dismiss()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 16)
            }
            .background(AppTheme.bg)
        }
    }
}
