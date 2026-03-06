import SwiftUI

struct SwipeCardView: View {
    let card: PredictionCard
    let isTop: Bool
    let stackOffset: Int          // 0 = top, 1, 2 = behind
    let onSwipe: (SwipeDirection) -> Void

    @State private var offset: CGSize = .zero
    private let threshold: CGFloat = 120

    var body: some View {
        GeometryReader { geo in
            let h = geo.size.height
            let w = geo.size.width

            ZStack(alignment: .top) {
                // Card
                VStack(spacing: 0) {
                    // Top 45%: image
                    AsyncImage(url: URL(string: card.imageURL)) { phase in
                        switch phase {
                        case .success(let img): img.resizable().scaledToFill()
                        default: Rectangle().fill(AppTheme.border)
                        }
                    }
                    .frame(width: w, height: h * 0.45)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            colors: [.black.opacity(0.5), .clear],
                            startPoint: .bottom,
                            endPoint: .center
                        )
                    )

                    // Bottom 55%: content
                    VStack(alignment: .leading, spacing: 14) {
                        // Deadline badge
                        HStack(spacing: 5) {
                            Image(systemName: "clock.fill")
                                .font(.caption.bold())
                            Text("Осталось \(card.daysLeft) дн.")
                                .font(.caption.bold())
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(AppTheme.danger)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        // Question
                        Text(card.question)
                            .font(.title3.bold())
                            .foregroundStyle(AppTheme.textPrimary)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)

                        // Vote bar
                        VStack(spacing: 6) {
                            HStack {
                                Text("Да \(Int(card.yesPercent))%")
                                    .font(.caption.bold())
                                    .foregroundStyle(AppTheme.success)
                                Spacer()
                                Text("Нет \(Int(card.noPercent))%")
                                    .font(.caption.bold())
                                    .foregroundStyle(AppTheme.danger)
                            }
                            GeometryReader { bar in
                                HStack(spacing: 2) {
                                    Rectangle()
                                        .fill(AppTheme.success)
                                        .frame(width: bar.size.width * card.yesPercent / 100)
                                    Rectangle()
                                        .fill(AppTheme.danger)
                                }
                            }
                            .frame(height: 6)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                        }

                        Text("🗳 \(card.totalVotes.formatted()) голосов")
                            .font(.caption)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .frame(height: h * 0.55, alignment: .top)
                    .background(AppTheme.card)
                }
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: AppTheme.cardRadius,
                        bottomLeadingRadius: AppTheme.cardRadius,
                        bottomTrailingRadius: AppTheme.cardRadius,
                        topTrailingRadius: AppTheme.cardRadius
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                        .strokeBorder(AppTheme.border, lineWidth: 1)
                )

                // YES / NO overlays
                if isTop {
                    HStack {
                        // NO overlay (left)
                        yesNoOverlay(text: "НЕТ", color: AppTheme.danger, angle: -10,
                                     opacity: offset.width < -20 ? Double(min(abs(offset.width) / threshold, 1.0)) : 0)
                        Spacer()
                        // YES overlay (right)
                        yesNoOverlay(text: "ДА", color: AppTheme.success, angle: 10,
                                     opacity: offset.width > 20 ? Double(min(abs(offset.width) / threshold, 1.0)) : 0)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
            }
            .offset(x: isTop ? offset.width : 0, y: isTop ? offset.height * 0.1 : 0)
            .rotationEffect(.degrees(isTop ? Double(offset.width) / 30 * 12 : 0))
            .gesture(
                isTop ? DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { value in
                        let x = value.translation.width
                        if x > threshold {
                            flyOff(direction: .right)
                        } else if x < -threshold {
                            flyOff(direction: .left)
                        } else {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                offset = .zero
                            }
                        }
                    }
                : nil
            )
        }
    }

    private func flyOff(direction: SwipeDirection) {
        let targetX: CGFloat = direction == .right ? 500 : -500
        withAnimation(.easeOut(duration: 0.35)) {
            offset = CGSize(width: targetX, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            onSwipe(direction)
            offset = .zero
        }
    }

    @ViewBuilder
    private func yesNoOverlay(text: String, color: Color, angle: Double, opacity: Double) -> some View {
        Text(text)
            .font(.title.bold())
            .foregroundStyle(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(color, lineWidth: 2)
            )
            .rotationEffect(.degrees(angle))
            .opacity(opacity)
    }
}
