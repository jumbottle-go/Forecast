import SwiftUI

struct HeroCardView: View {
    let item: NewsItem
    let votedOptionId: UUID?
    let article: Article?
    let onVote: (VoteOption) -> Void

    @State private var pulseOpacity: Double = 0.3

    var isVoted: Bool { votedOptionId != nil }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Image + badges + title
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: item.imageURL)) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFill()
                    default:
                        Rectangle().fill(AppTheme.card)
                    }
                }
                .frame(height: 200)
                .clipped()

                // Gradient overlay
                LinearGradient(
                    colors: [.black.opacity(0.7), .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 200)

                // Badges (top-left)
                VStack {
                    HStack {
                        if item.isBreaking {
                            BreakingBadge(pulseOpacity: pulseOpacity)
                        } else {
                            CategoryBadge(category: item.category)
                        }
                        Spacer()
                    }
                    .padding(12)
                    Spacer()
                }

                // Title at bottom of image
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    Text(item.title)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                }
            }
            .frame(height: 200)
            .clipped()

            // MARK: Content below image
            VStack(alignment: .leading, spacing: 14) {

                // Meta
                HStack(spacing: 6) {
                    Text(item.source)
                    Text("·")
                    Text(item.timeAgo)
                    Text("·")
                    Image(systemName: "person.2.fill")
                    Text("\(item.votesCount.formatted()) votes")
                }
                .font(.caption)
                .foregroundStyle(AppTheme.textSecondary)

                // Question
                Text(item.question)
                    .font(.headline)
                    .foregroundStyle(.white)

                // Vote buttons
                VStack(spacing: 10) {
                    ForEach(item.options) { option in
                        VoteButton(
                            option: option,
                            isSelected: votedOptionId == option.id,
                            isVoted: isVoted,
                            showSubtitle: true
                        ) {
                            onVote(option)
                        }
                    }
                }

                // Learn more
                if let article {
                    NavigationLink {
                        ArticleView(article: article)
                    } label: {
                        Text("Read more →")
                            .font(.subheadline.bold())
                            .foregroundStyle(AppTheme.accent)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
        }
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .onAppear {
            guard item.isBreaking else { return }
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                pulseOpacity = 1.0
            }
        }
    }
}

// MARK: - Sub-views

private struct BreakingBadge: View {
    let pulseOpacity: Double

    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(.white)
                .frame(width: 7, height: 7)
                .opacity(pulseOpacity)
            Text("BREAKING")
                .font(.caption.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(AppTheme.danger)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

