import SwiftUI

struct FeedCardView: View {
    let item: NewsItem
    let votedOptionId: UUID?
    let article: Article?
    let onVote: (VoteOption) -> Void
    var onCardTap: ((Article) -> Void)? = nil

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
                .offset(x: dragOffset + wiggleOffset)
                .rotationEffect(.degrees(Double(dragOffset) / 25 * 8 / swipeThreshold))
                // High-priority drag cancels tap evaluation
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
            guard !isVoted else { return }
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
        VStack(alignment: .leading, spacing: 0) {

            // Image
            ZStack {
                AsyncImage(url: URL(string: item.imageURL)) { phase in
                    switch phase {
                    case .success(let img): img.resizable().scaledToFill()
                    default: Rectangle().fill(AppTheme.border)
                    }
                }
                .frame(height: 110)
                .clipped()

                LinearGradient(
                    colors: [.black.opacity(0.7), .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 110)

                // Category chip (top-left) + vote count chip (top-right)
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
                    .padding(8)
                    Spacer()
                }

                // Title — pinned bottom-left
                VStack {
                    Spacer()
                    Text(item.title)
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 8)
                }
            }
            .frame(height: 110)
            .clipped()

            // Below image
            VStack(alignment: .leading, spacing: 10) {
                // Prediction question
                Text(item.question)
                    .font(.subheadline.bold())
                    .foregroundStyle(AppTheme.textPrimary)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 4)

                // AI analytics badge
                if let analysis = item.aiAnalysis {
                    Button { showAnalytics = true } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "sparkles")
                                .font(.caption.bold())
                                .foregroundStyle(AppTheme.accent)
                            Text(analysis.summary)
                                .font(.caption.bold())
                                .foregroundStyle(AppTheme.accent)
                                .lineLimit(1)
                            Spacer(minLength: 0)
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(AppTheme.textSecondary)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(AppTheme.accent.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(AppTheme.accent.opacity(0.25), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }

                // Vote buttons in HStack
                if item.options.count >= 2 {
                    HStack(spacing: 8) {
                        ForEach(item.options.prefix(2)) { option in
                            VoteButton(
                                option: option,
                                isSelected: votedOptionId == option.id,
                                isVoted: isVoted,
                                showSubtitle: false
                            ) {
                                onVote(option)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }

            }
            .padding(12)
        }
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                .strokeBorder(AppTheme.border, lineWidth: 1)
        )
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
