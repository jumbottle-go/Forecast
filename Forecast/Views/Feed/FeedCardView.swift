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
                AnalyticsSheetView(
                    analysis: analysis,
                    voteQuestion: item.question,
                    voteOptions: item.options,
                    votesCount: item.votesCount,
                    votedOptionId: votedOptionId,
                    onVote: { option in onVote(option) }
                )
            }
        }
    }

    // MARK: Card Content

    @ViewBuilder
    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 0) {

            // MARK: Image area
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: item.imageURL)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    } else {
                        Color(white: 0.15)
                    }
                }
                .frame(height: 140)
                .clipped()

                // Bottom gradient
                LinearGradient(
                    colors: [.black.opacity(0.65), .clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
                .frame(height: 140)
                .allowsHitTesting(false)

                // Top bar: category pill (left) + AI button (right)
                VStack {
                    HStack {
                        // Category pill
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
                        .clipShape(Capsule())

                        Spacer()

                        // AI interactive pill
                        if let shortAnswer = item.aiShortAnswer, item.aiAnalysis != nil {
                            Button { showAnalytics = true } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "sparkles")
                                    Text("AI: \(shortAnswer)")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                    Image(systemName: "chevron.right")
                                        .font(.caption2.bold())
                                        .opacity(0.8)
                                }
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(
                                            Color(white: 0.15)
                                                .shadow(.inner(color: .black.opacity(0.9), radius: 3, x: 0, y: 3))
                                                .shadow(.inner(color: .white.opacity(0.2), radius: 2, x: 0, y: -1))
                                        )
                                )
                                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(12)
                    Spacer()
                }

                // News title pinned bottom-left
                HStack {
                    Text(item.title)
                        .font(.caption.bold())
                        .foregroundStyle(.white.opacity(0.85))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
            }
            .frame(height: 140)
            .clipped()

            // MARK: Content area
            VStack(alignment: .leading, spacing: 10) {

                // Prediction question — main element
                Text(item.question)
                    .font(.headline)
                    .foregroundStyle(AppTheme.textPrimary)
                    .lineLimit(2)
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

                    // Vote count
                    HStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                        Text("\(item.votesCount.formatted()) голосов")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                }

            }
            .padding(12)
            .background(AppTheme.card)
        }
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
        .offset(x: dragOffset + wiggleOffset)
    }
}
