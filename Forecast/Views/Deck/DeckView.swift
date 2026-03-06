import SwiftUI

struct DeckView: View {
    let cards: [PredictionCard]
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel: DeckViewModel

    init(cards: [PredictionCard]) {
        self.cards = cards
        _viewModel = StateObject(wrappedValue: DeckViewModel(cards: cards))
    }

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            if viewModel.isComplete {
                completionView
            } else {
                mainDeckView
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: Main deck

    private var mainDeckView: some View {
        VStack(spacing: 0) {

            // Top bar
            HStack {
                ProgressSegments(total: viewModel.totalCards, filled: viewModel.progress)
                    .frame(maxWidth: .infinity)

                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "xmark")
                            .font(.subheadline.bold())
                        Text("Закрыть")
                            .font(.subheadline)
                    }
                    .foregroundStyle(AppTheme.textSecondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 56)
            .padding(.bottom, 20)

            Spacer()

            // Card stack
            GeometryReader { geo in
                let cardH = geo.size.height * 0.72
                let cardW  = geo.size.width - 40

                ZStack {
                    ForEach(Array(viewModel.visibleCards.reversed()), id: \.card.id) { item in
                        let stackDepth = item.index
                        SwipeCardView(
                            card: item.card,
                            isTop: stackDepth == 0,
                            stackOffset: stackDepth
                        ) { direction in
                            viewModel.swipe(direction: direction)
                        }
                        .frame(width: cardW, height: cardH)
                        .scaleEffect(1.0 - Double(stackDepth) * 0.04)
                        .offset(y: Double(stackDepth) * -14)
                        .zIndex(Double(10 - stackDepth))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.currentIndex)
                    }
                }
                .frame(maxWidth: .infinity)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }

            Spacer()

            // Hint + AI button
            VStack(spacing: 14) {
                Text("← Нет  |  свайп  |  Да →")
                    .font(.caption)
                    .foregroundStyle(AppTheme.textSecondary)

                Button {
                    viewModel.toggleAIPanel()
                } label: {
                    HStack(spacing: 6) {
                        Text("🤖")
                        Text("ИИ-Аналитика")
                            .font(.subheadline.bold())
                            .foregroundStyle(AppTheme.accent)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(AppTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.buttonRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.buttonRadius)
                            .strokeBorder(AppTheme.border, lineWidth: 1)
                    )
                }

                if viewModel.showAIPanel, let card = viewModel.currentCard {
                    aiPanel(for: card)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 36)
        }
    }

    // MARK: AI Panel

    @ViewBuilder
    private func aiPanel(for card: PredictionCard) -> some View {
        ScrollView {
            Text(card.aiAnalysis)
                .font(.subheadline)
                .foregroundStyle(AppTheme.textPrimary)
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 180)
        .padding(14)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                .strokeBorder(AppTheme.accent.opacity(0.4), lineWidth: 1)
        )
    }

    // MARK: Completion screen

    private var completionView: some View {
        VStack(spacing: 28) {
            Spacer()

            Text("Готово!")
                .font(.largeTitle.bold())
                .foregroundStyle(AppTheme.textPrimary)

            Text("Вы ответили на \(viewModel.totalCards) предсказаний")
                .font(.headline)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)

            // Summary
            VStack(spacing: 10) {
                ForEach(cards) { card in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(AppTheme.success)
                        Text(card.question)
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textPrimary)
                            .lineLimit(1)
                        Spacer()
                        if let dir = viewModel.votes[card.id] {
                            Text(dir == .right ? "Да" : "Нет")
                                .font(.caption.bold())
                                .foregroundStyle(dir == .right ? AppTheme.success : AppTheme.danger)
                        }
                    }
                }
            }
            .padding(16)
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cardRadius))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cardRadius)
                    .strokeBorder(AppTheme.border, lineWidth: 1)
            )
            .padding(.horizontal, 20)

            Spacer()

            Button {
                dismiss()
            } label: {
                Text("Назад в ленту")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(AppTheme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.buttonRadius))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
}
