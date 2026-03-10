import SwiftUI

struct FlashHeroView: View {

    var onReadArticle: ((FlashCard) -> Void)? = nil
    @Binding var cardsRemaining: Int
    @EnvironmentObject private var feedViewModel: FeedViewModel

    @State private var cards: [FlashCard] = MockData.flashCards
    @State private var dragOffset: CGSize = .zero
    @State private var isSwiping = false
    @State private var activeCard: FlashCard? = nil

    private let totalCount = MockData.flashCards.count
    private let swipeThreshold: CGFloat = 100
    private var cardHeight: CGFloat {
        UIScreen.main.bounds.height * 0.55
    }

    // Streak widget data (hardcoded for MVP)
    private let weekDays: [(String, Bool)] = [
        ("Пн", true), ("Вт", true), ("Ср", true), ("Чт", false), ("Пт", false)
    ]

    var body: some View {
        Group {
            if cards.isEmpty {
                streakWidget
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.92).combined(with: .opacity),
                        removal: .opacity
                    ))
            } else {
                activeStack
                    .transition(.opacity)
            }
        }
        .animation(.spring(response: 0.45, dampingFraction: 0.78), value: cards.isEmpty)
        .padding(.horizontal, 16)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ArticleDismissedSwipe"))) { _ in
            if let topCard = cards.last,
               let votedOptionId = feedViewModel.votedOptionId(for: topCard.id),
               let newsItem = feedViewModel.allNews.first(where: { $0.id == topCard.id }),
               newsItem.options.contains(where: { $0.id == votedOptionId }) {

                cards.removeAll { $0.id != topCard.id && feedViewModel.isVoted(for: $0.id) }
                let isFirstOption = newsItem.options.first?.id == votedOptionId
                swipe(to: isFirstOption ? .right : .left)
            }
        }
        .onChange(of: cards.count) { _, _ in cardsRemaining = cards.count }
        .sheet(item: $activeCard) { card in
            AnalyticsSheetView(
                analysis: card.aiAnalysis,
                voteQuestion: card.question,
                voteOptions: flashVoteOptions(for: card),
                votesCount: card.votesCount,
                votedOptionId: feedViewModel.votedOptionId(for: card.id),
                onVote: { option in
                    feedViewModel.castVote(for: card.id, option: option)
                    let opts = flashVoteOptions(for: card)
                    let isFirst = opts.first?.id == option.id
                    swipe(to: isFirst ? .right : .left)
                }
            )
        }
    }

    // MARK: Active Stack

    private var activeStack: some View {
        ZStack {
            ForEach(Array(visibleCards.enumerated()), id: \.element.id) { idx, card in
                let isTop = idx == visibleCards.count - 1
                let depth = visibleCards.count - 1 - idx  // 0 = top

                cardView(card: card, isTop: isTop)
                    .scaleEffect(1.0 - CGFloat(depth) * 0.035, anchor: .top)
                    .offset(y: CGFloat(depth) * 14)
                    .zIndex(Double(idx))
                    .offset(
                        x: isTop ? dragOffset.width : 0,
                        y: isTop ? dragOffset.height * 0.10 : 0
                    )
                    .rotationEffect(
                        .degrees(isTop ? Double(dragOffset.width) / 28 : 0),
                        anchor: .bottom
                    )
                    // simultaneousGesture lets Buttons and DragGesture both fire
                    .simultaneousGesture(isTop ? dragGesture : nil)
            }
        }
        .frame(height: cardHeight + 36)
    }

    private var visibleCards: [FlashCard] {
        Array(cards.suffix(min(cards.count, 3)))
    }

    // MARK: Programmatic swipe

    private enum SwipeDirection { case left, right }

    private func swipe(to direction: SwipeDirection) {
        guard !isSwiping, !cards.isEmpty else { return }
        isSwiping = true
        let exitX: CGFloat = direction == .right ? 500 : -500
        withAnimation(.easeOut(duration: 0.22)) {
            dragOffset = CGSize(width: exitX, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                if !cards.isEmpty { cards.removeLast() }
                dragOffset = .zero
            }
            isSwiping = false
        }
    }

    // MARK: Vote options helper

    // Constructs [ДА, НЕТ] VoteOption pair for a flash card.
    // Order matches VotingBlockView's [success, danger] color assignment.
    // Percentages are derived from AI confidence so the bar fills correctly after voting.
    private func flashVoteOptions(for card: FlashCard) -> [VoteOption] {
        let ai = card.aiAnalysis
        let daPercent = ai.prosLabel == "ДА"
            ? Double(ai.confidencePercent)
            : Double(100 - ai.confidencePercent)
        let netPercent = 100.0 - daPercent
        return [
            VoteOption(iconName: "checkmark.circle.fill", text: "ДА",  subtitle: "", percent: daPercent),
            VoteOption(iconName: "xmark.circle.fill",    text: "НЕТ", subtitle: "", percent: netPercent)
        ]
    }

    // MARK: Category helpers

    private func categoryEmoji(for category: String) -> String {
        switch category {
        case "Finance":  return "📈"
        case "Sports":   return "⚽"
        case "Crypto":   return "₿"
        case "Tech":     return "💻"
        default:         return "🔮"
        }
    }

    private func categoryGradient(for category: String) -> LinearGradient {
        let colors: [Color]
        switch category {
        case "Finance":
            colors = [Color(red: 0.04, green: 0.22, blue: 0.42), Color(red: 0.08, green: 0.36, blue: 0.58)]
        case "Sports":
            colors = [Color(red: 0.06, green: 0.20, blue: 0.08), Color(red: 0.12, green: 0.36, blue: 0.14)]
        case "Crypto":
            colors = [Color(red: 0.28, green: 0.14, blue: 0.02), Color(red: 0.55, green: 0.30, blue: 0.04)]
        case "Tech":
            colors = [Color(red: 0.10, green: 0.06, blue: 0.26), Color(red: 0.30, green: 0.28, blue: 0.65)]
        default:
            colors = [Color(red: 0.10, green: 0.10, blue: 0.16), Color(red: 0.18, green: 0.18, blue: 0.26)]
        }
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    // MARK: Card View

    @ViewBuilder
    private func cardView(card: FlashCard, isTop: Bool) -> some View {
        ZStack {

            // 1. Background image constrained to parent bounds
            Color.clear
                .overlay(
                    AsyncImage(url: URL(string: card.imageURL)) { phase in
                        if let img = phase.image {
                            img.resizable().scaledToFill()
                        } else {
                            categoryGradient(for: card.category)
                        }
                    }
                )
                .clipped()

            // 2. Dark vignette — clear at top, opaque at bottom
            LinearGradient(
                colors: [.clear, .black.opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
            )

            // 3. All interactive content
            VStack(alignment: .leading, spacing: 0) {

                // ── Top bar ──────────────────────────────────────────
                HStack(alignment: .top) {

                    // Category badge (top-left) — identical style to feed cards
                    HStack(spacing: 4) {
                        Image(systemName: card.symbol)
                            .font(.caption2.bold())
                        Text(card.category)
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.black.opacity(0.4))
                    .clipShape(Capsule())

                    Spacer()

                    // AI analytics button (top-right)
                    Button {
                        activeCard = card
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "sparkles")
                            Text("AI: \(card.aiShortAnswer)")
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
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()

                // ── Bottom content block ─────────────────────────────
                VStack(alignment: .leading, spacing: 10) {

                    // Question headline
                    Text(card.question)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .lineLimit(4)
                        .minimumScaleFactor(0.8)
                }
                .padding(.horizontal, 20)

                // ── Swipe buttons ────────────────────────────────────
                HStack(spacing: 12) {

                    // ДА (успех)
                    Button { swipe(to: .right) } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark")
                            Text("ДА")
                        }
                        .font(.subheadline.bold())
                        .foregroundStyle(AppTheme.success)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(AppTheme.success.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(AppTheme.success.opacity(0.35), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)

                    // НЕТ (отказ)
                    Button { swipe(to: .left) } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "xmark")
                            Text("НЕТ")
                        }
                        .font(.subheadline.bold())
                        .foregroundStyle(AppTheme.danger)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(AppTheme.danger.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(AppTheme.danger.opacity(0.35), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                // 📄 Читать новость — ghost secondary action
                Button { onReadArticle?(card) } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text")
                        Text("Читать новость")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.55))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 20)
            }

            // 4. Directional colour tint while dragging
            if isTop {
                Rectangle()
                    .fill(swipeTintColor.opacity(swipeTintOpacity))
                    .allowsHitTesting(false)
            }

            // 5. Tinder stamp labels (НЕТ / ДА)
            if isTop {
                if dragOffset.width < -20 {
                    Text("НЕТ")
                        .font(.title.bold())
                        .foregroundStyle(AppTheme.danger)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(AppTheme.danger, lineWidth: 3))
                        .rotationEffect(.degrees(-18))
                        .opacity(leftHintOpacity)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.leading, 28).padding(.top, 64)
                        .allowsHitTesting(false)
                }
                if dragOffset.width > 20 {
                    Text("ДА")
                        .font(.title.bold())
                        .foregroundStyle(AppTheme.success)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(AppTheme.success, lineWidth: 3))
                        .rotationEffect(.degrees(18))
                        .opacity(rightHintOpacity)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing, 28).padding(.top, 64)
                        .allowsHitTesting(false)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: cardHeight)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.55), radius: 24, x: 0, y: 12)
    }

    // MARK: Gesture helpers

    private var leftHintOpacity: Double {
        dragOffset.width < -30
            ? Double(min((-dragOffset.width - 30) / 60, 1.0))
            : 0.0
    }

    private var rightHintOpacity: Double {
        dragOffset.width > 30
            ? Double(min((dragOffset.width - 30) / 60, 1.0))
            : 0.0
    }

    private var swipeTintOpacity: Double {
        Double(min(abs(dragOffset.width) / 160, 0.20))
    }

    private var swipeTintColor: Color {
        if dragOffset.width > 30 { return AppTheme.success }
        if dragOffset.width < -30 { return AppTheme.danger }
        return .clear
    }

    // MARK: Drag Gesture
    // Uses regular .gesture (not highPriority) so Buttons inside the card win on tap

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { value in
                guard !isSwiping else { return }
                // Prefer horizontal drags; ignore vertical scroll intent
                guard abs(value.translation.width) > abs(value.translation.height) * 0.6 else { return }
                dragOffset = value.translation
            }
            .onEnded { value in
                guard !isSwiping else { return }
                let dx = value.translation.width
                if abs(dx) > swipeThreshold {
                    swipe(to: dx > 0 ? .right : .left)
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        dragOffset = .zero
                    }
                }
            }
    }

    // MARK: Page Indicator

    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalCount, id: \.self) { i in
                let answered = totalCount - cards.count
                Capsule()
                    .fill(i < answered ? AppTheme.accent : AppTheme.border)
                    .frame(width: i < answered ? 18 : 6, height: 6)
                    .animation(.spring(response: 0.35), value: answered)
            }
        }
    }

    // MARK: Streak Widget

    private var streakWidget: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("🔥 3 дня подряд")
                    .font(.subheadline.bold())
                    .foregroundStyle(AppTheme.textPrimary)
                Text("×1.5 множитель активен")
                    .font(.caption)
                    .foregroundStyle(AppTheme.accent)
            }

            Spacer()

            HStack(spacing: 8) {
                ForEach(weekDays.indices, id: \.self) { i in
                    let (day, done) = weekDays[i]
                    VStack(spacing: 3) {
                        Text(day)
                            .font(.system(size: 9, weight: .medium))
                            .foregroundStyle(AppTheme.textSecondary)
                        Image(systemName: done ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 14))
                            .foregroundStyle(done ? AppTheme.success : AppTheme.border)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
    }
}
