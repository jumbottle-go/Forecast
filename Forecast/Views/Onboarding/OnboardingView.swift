import SwiftUI

struct OnboardingView: View {

    var onFinish: () -> Void

    @State private var selectedCategories: Set<String> = []

    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine3 = false
    @State private var showCategories = false

    private struct Topic {
        let name: String
        let icon: String
    }

    private let topics: [Topic] = [
        Topic(name: "Finance",     icon: "chart.line.uptrend.xyaxis"),
        Topic(name: "Tech",        icon: "desktopcomputer"),
        Topic(name: "Crypto",      icon: "bitcoinsign.circle.fill"),
        Topic(name: "Politics",    icon: "building.columns.fill"),
        Topic(name: "Sports",      icon: "sportscourt.fill"),
        Topic(name: "Pop Culture", icon: "popcorn.fill")
    ]

    private var topicRows: [[Topic]] {
        stride(from: 0, to: topics.count, by: 2).map {
            Array(topics[$0 ..< min($0 + 2, topics.count)])
        }
    }

    private var canContinue: Bool { selectedCategories.count >= 2 }

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // ── Kinetic headline ────────────────────────────────────
                VStack(alignment: .leading, spacing: 4) {
                    headlineLine("Read the news.", show: showLine1, color: AppTheme.textPrimary)
                    headlineLine("Predict outcomes.", show: showLine2, color: AppTheme.textPrimary)
                    headlineLine("Compete.", show: showLine3, color: AppTheme.accent)
                }
                .padding(.top, 72)
                .padding(.horizontal, 24)

                // ── Categories block ────────────────────────────────────
                if showCategories {
                    VStack(alignment: .leading, spacing: 16) {

                        Text("Choose your topics")
                            .font(.title3.bold())
                            .foregroundStyle(AppTheme.textSecondary)

                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(topicRows.indices, id: \.self) { rowIdx in
                                HStack(spacing: 16) {
                                    ForEach(topicRows[rowIdx], id: \.name) { topic in
                                        topicPill(topic)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 24)
                    .transition(.opacity.combined(with: .offset(y: 10)))

                    // ── Continue button ─────────────────────────────────
                    continueButton
                        .padding(.horizontal, 24)
                        .padding(.top, 40)
                }

                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                withAnimation(.easeOut(duration: 0.4)) { showLine1 = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.4)) { showLine2 = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut(duration: 0.4)) { showLine3 = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) { showCategories = true }
            }
        }
    }

    // MARK: Headline line

    @ViewBuilder
    private func headlineLine(_ text: String, show: Bool, color: Color) -> some View {
        Text(text)
            .font(.system(size: 40, weight: .heavy))
            .foregroundStyle(color)
            .opacity(show ? 1 : 0)
            .offset(y: show ? 0 : 10)
    }

    // MARK: Topic pill

    @ViewBuilder
    private func topicPill(_ topic: Topic) -> some View {
        let selected = selectedCategories.contains(topic.name)
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                if selected {
                    selectedCategories.remove(topic.name)
                } else {
                    selectedCategories.insert(topic.name)
                }
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: topic.icon)
                    .imageScale(.large)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(selected ? AppTheme.accent : .white)
                Text(topic.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(selected ? AppTheme.accent : .white)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 18)
            .background(selected ? AppTheme.accent.opacity(0.2) : Color.white.opacity(0.05))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(selected ? AppTheme.accent : Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: Continue button

    private var continueButton: some View {
        Button {
            if canContinue { onFinish() }
        } label: {
            Text(canContinue ? "Continue →" : "Select at least 2")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(canContinue ? .white : Color.white.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(canContinue ? AppTheme.accent : Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .disabled(!canContinue)
        .animation(.easeInOut(duration: 0.25), value: canContinue)
    }
}
