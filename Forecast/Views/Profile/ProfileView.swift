import SwiftUI

// MARK: - Local mock models

private struct CategoryStrength {
    let icon: String
    let name: String
    let winRate: Int

    var color: Color {
        if winRate >= 65 { return Color(hex: "34C759") }
        if winRate >= 45 { return Color(hex: "FFD60A") }
        return Color(hex: "FF453A")
    }
}

private struct ProfilePrediction {
    enum Status {
        case correct, wrong, pending

        var iconName: String {
            switch self {
            case .correct: return "checkmark.circle.fill"
            case .wrong:   return "xmark.circle.fill"
            case .pending: return "clock"
            }
        }

        var color: Color {
            switch self {
            case .correct: return AppTheme.success
            case .wrong:   return AppTheme.danger
            case .pending: return AppTheme.textSecondary
            }
        }
    }

    let categoryIcon: String
    let category: String
    let question: String
    let answer: String
    let status: Status
}

// MARK: - ProfileView

struct ProfileView: View {

    // ── Mock data ──────────────────────────────────────────────────────────
    private let isTopLeague      = true
    private let leagueProgress: CGFloat = 0.78

    private let strengths: [CategoryStrength] = [
        CategoryStrength(icon: "chart.line.uptrend.xyaxis", name: "Finance",  winRate: 74),
        CategoryStrength(icon: "desktopcomputer",           name: "Tech",     winRate: 68),
        CategoryStrength(icon: "building.columns.fill",     name: "Politics", winRate: 52)
    ]

    private let predictions: [ProfilePrediction] = [
        ProfilePrediction(categoryIcon: "chart.line.uptrend.xyaxis", category: "Finance",
                          question: "Will Fed cut rates?",
                          answer: "Заморозит", status: .correct),
        ProfilePrediction(categoryIcon: "desktopcomputer", category: "Tech",
                          question: "Apple Vision Pro 2 sales?",
                          answer: "< 1 млн", status: .pending),
        ProfilePrediction(categoryIcon: "building.columns.fill", category: "Politics",
                          question: "EU reaction to GPT-5?",
                          answer: "Запрет", status: .wrong),
        ProfilePrediction(categoryIcon: "chart.line.uptrend.xyaxis", category: "Finance",
                          question: "Bitcoin hits $100K?",
                          answer: "ДА", status: .correct)
    ]

    // ── Body ───────────────────────────────────────────────────────────────

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 12) {
                    headerBlock
                    metricsBlock
                    leagueProgressBlock
                    strengthsBlock
                    predictionsBlock
                    Color.clear.frame(height: 20)
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    // MARK: Block 1 — Header

    private var headerBlock: some View {
        VStack(spacing: 6) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(AppTheme.textSecondary)

            Text("Alex Morgan")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            if isTopLeague {
                Text("#47 в рейтинге")
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .padding(.bottom, 16)
    }

    // MARK: Block 2 — Key metrics

    private var metricsBlock: some View {
        HStack(spacing: 0) {
            // League
            metricView(label: "Лига") {
                HStack(spacing: 5) {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(Color(hex: "FFD700"))
                    Text("Gold")
                        .foregroundStyle(AppTheme.textPrimary)
                }
                .font(.system(size: 24, weight: .bold))
            }

            divider

            // Winrate
            metricView(label: "Winrate") {
                Text("61%")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
            }

            divider

            // Predictions count
            metricView(label: "Прогнозов") {
                Text("342")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private func metricView<V: View>(label: String, @ViewBuilder value: () -> V) -> some View {
        VStack(spacing: 4) {
            value()
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.12))
            .frame(width: 0.5, height: 36)
    }

    // MARK: Block 3 — League progress

    private var leagueProgressBlock: some View {
        VStack(alignment: .leading, spacing: 10) {

            // League transition label
            HStack(spacing: 6) {
                Text("Gold")
                    .foregroundStyle(Color(hex: "FFD700"))
                Text("→")
                    .foregroundStyle(AppTheme.textSecondary)
                Text("Platinum")
                    .foregroundStyle(Color(hex: "E5E4E2"))
            }
            .font(.system(size: 16, weight: .semibold))

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.10))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(
                            colors: [Color(hex: "FFD700"), Color(hex: "E5E4E2")],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: geo.size.width * leagueProgress, height: 8)
                }
            }
            .frame(height: 8)

            Text("780 / 1000 XP")
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: Block 4 — Strengths

    private var strengthsBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Сильные стороны")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            VStack(spacing: 10) {
                ForEach(strengths, id: \.name) { item in
                    HStack {
                        Image(systemName: item.icon)
                            .font(.system(size: 14))
                            .foregroundStyle(AppTheme.textSecondary)
                            .frame(width: 20)
                        Text(item.name)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(AppTheme.textPrimary)
                        Spacer()
                        Text("\(item.winRate)%")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(item.color)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: Block 5 — Recent predictions

    private var predictionsBlock: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Section header
            HStack {
                Text("Последние прогнозы")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
                Spacer()
                Button("Все →") { }
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.accent)
            }
            .padding(.horizontal, 16)

            // Horizontal carousel
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(predictions, id: \.question) { pred in
                        predictionCard(pred)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    private func predictionCard(_ pred: ProfilePrediction) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            // Category
            HStack(spacing: 4) {
                Image(systemName: pred.categoryIcon)
                    .font(.system(size: 12))
                Text(pred.category)
                    .font(.system(size: 12))
            }
            .foregroundStyle(AppTheme.textSecondary)

            // Question
            Text(pred.question)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppTheme.textPrimary)
                .lineLimit(2)
                .truncationMode(.tail)

            Spacer(minLength: 0)

            // Answer + status icon
            HStack(spacing: 4) {
                Text(pred.answer)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(pred.status.color)
                Image(systemName: pred.status.iconName)
                    .font(.system(size: 13))
                    .foregroundStyle(pred.status.color)
            }
        }
        .padding(12)
        .frame(width: 200)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
