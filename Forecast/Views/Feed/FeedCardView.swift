import SwiftUI

struct FeedCardView: View {
    let item: NewsItem
    let votedOptionId: UUID?
    let article: Article?
    let onVote: (VoteOption) -> Void
    var onCardTap: ((Article) -> Void)? = nil

    @AppStorage("hasUserSwiped") private var hasUserSwiped = false
    static var hasWiggledThisSession = false

    @State private var dragOffset: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var showAnalytics: Bool = false
    @State private var wiggleOffset: CGFloat = 0

    private let swipeThreshold: CGFloat = 100

    var isVoted: Bool { votedOptionId != nil }

    var body: some View {
        ZStack {
            // Background swipe labels
            if isDragging {
                HStack {
                    swipeLabel(item.options.first, isLeft: true)
                    Spacer()
                    swipeLabel(item.options.last, isLeft: false)
                }
                .padding(.horizontal, 20)
            }

            // Card
            cardContent
                .onTapGesture {
                    guard !isDragging, let article else { return }
                    onCardTap?(article)
                }
                .rotationEffect(.degrees(Double(dragOffset) / 25 * 8 / swipeThreshold))
                .highPriorityGesture(
                    DragGesture(minimumDistance: 20)
                        .onChanged { value in
                            guard !isVoted else { return }
                            guard abs(value.translation.width) > abs(value.translation.height) else { return }
                            isDragging = true
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            isDragging = false
                            let total = value.translation.width
                            if abs(total) > swipeThreshold {
                                let option = total < 0
                                    ? (item.options.first ?? item.options[0])
                                    : (item.options.last ?? item.options[0])
                                withAnimation(.easeOut(duration: 0.2)) { dragOffset = 0 }
                                hasUserSwiped = true
                                onVote(option)
                            } else {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    dragOffset = 0
                                }
                            }
                        }
                )
        }
        .padding(.horizontal, 16)
        .onAppear {
            guard !hasUserSwiped && !FeedCardView.hasWiggledThisSession else { return }
            FeedCardView.hasWiggledThisSession = true
            withAnimation(.easeInOut(duration: 0.15).repeatCount(4, autoreverses: true).delay(1.0)) {
                wiggleOffset = 10
            }
        }
        .sheet(isPresented: $showAnalytics) {
            if let analysis = item.aiAnalysis {
                AnalyticsSheetView(analysis: analysis)
            }
        }
    }

    // MARK: Card Content

    @ViewBuilder
    private var cardContent: some View {
        ZStack(alignment: .bottom) {
            // Full-bleed image
            AsyncImage(url: URL(string: item.imageURL)) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFill()
                } else {
                    Color(white: 0.15)
                }
            }
            .clipped()

            // Gradient overlay: clear top → black bottom 60%
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.0),
                    .init(color: .clear, location: 0.35),
                    .init(color: .black.opacity(0.85), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            // Top chips (category + vote count)
            VStack {
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: item.category.symbol)
                            .font(.caption2.bold())
                        Text(item.category.rawValue)
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .font(.caption2.bold())
                        Text(item.votesCount.formatted())
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .padding(12)
                Spacer()
            }

            // Bottom-aligned content
            VStack(alignment: .leading, spacing: 10) {
                // News title — subtle
                Text(item.title)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.65))
                    .lineLimit(2)

                // Question — hero
                Text(item.question)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                // Vote buttons
                if item.options.count >= 2 {
                    let colors: [Color] = [AppTheme.success, AppTheme.danger]
                    HStack(spacing: 8) {
                        ForEach(Array(item.options.prefix(2).enumerated()), id: \.element.id) { idx, option in
                            VoteButton(
                                option: option,
                                isSelected: votedOptionId == option.id,
                                isVoted: isVoted,
                                showSubtitle: false,
                                tintColor: colors[idx]
                            ) {
                                onVote(option)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }

                // AI analytics badge
                if let analysis = item.aiAnalysis {
                    Button { showAnalytics = true } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "sparkles")
                                .font(.caption2.bold())
                                .foregroundStyle(AppTheme.accent)
                            Text(analysis.summary)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.55))
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(14)
        }
        .frame(maxWidth: .infinity, minHeight: 360)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
        .offset(x: dragOffset + wiggleOffset)
    }

    @ViewBuilder
    private func swipeLabel(_ option: VoteOption?, isLeft: Bool) -> some View {
        if let option {
            let opacity = min(abs(dragOffset) / swipeThreshold, 1.0)
            let show = isLeft ? dragOffset < -10 : dragOffset > 10
            Label(option.text, systemImage: option.iconName)
                .font(.subheadline.bold())
                .foregroundStyle(isLeft ? AppTheme.danger : AppTheme.success)
                .opacity(show ? Double(opacity) : 0)
        }
    }
}
