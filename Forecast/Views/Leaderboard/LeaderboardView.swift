import SwiftUI

struct LeaderboardView: View {

    @Binding var selectedTab: Int

    // MARK: - Mock data

    private struct League {
        let iconName: String
        let name: String
        let color: Color
    }

    private let leagues: [League] = [
        League(iconName: "suit.diamond.fill", name: "Diamond",  color: Color(hex: "B9F2FF")),
        League(iconName: "shield.fill",       name: "Platinum", color: Color(hex: "E5E4E2")),
        League(iconName: "medal.fill",        name: "Gold",     color: Color(hex: "FFD700")),
        League(iconName: "medal.fill",        name: "Silver",   color: Color(hex: "C0C0C0")),
        League(iconName: "medal.fill",        name: "Bronze",   color: Color(hex: "CD7F32"))
    ]

    private let bronzeColor = Color(hex: "CD7F32")
    private let bronzeProgress: CGFloat = 0.4   // 2 of 5
    private let bronzeDone   = 2
    private let bronzeTotal  = 5

    private struct FeatureCard {
        let icon: String
        let text: String
    }

    private let features: [FeatureCard] = [
        FeatureCard(icon: "chart.bar.fill",       text: "Соревнуйся с игроками твоего уровня"),
        FeatureCard(icon: "arrow.up.circle.fill",  text: "Повышайся в лигах каждый месяц"),
        FeatureCard(icon: "flame.fill",            text: "Множители очков в высших лигах")
    ]

    // MARK: - Body

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Block 1 — Title
                    Text("Лиги")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 16)

                    // Block 2 — League ladder
                    leagueBlock

                    // Block 3 — Bronze CTA
                    bronzeBlock
                        .padding(.top, 16)

                    // Block 4 — Feature preview
                    featuresBlock
                        .padding(.top, 24)

                    Color.clear.frame(height: 24)
                }
            }
            .scrollIndicators(.hidden)
        }
    }

    // MARK: Block 2 — League ladder

    private var leagueBlock: some View {
        VStack(spacing: 0) {
            ForEach(Array(leagues.enumerated()), id: \.offset) { idx, league in
                leagueRow(league)
                if idx < leagues.count - 1 {
                    Rectangle()
                        .fill(Color.white.opacity(0.08))
                        .frame(height: 1)
                        .padding(.horizontal, 4)
                }
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    private func leagueRow(_ league: League) -> some View {
        HStack(spacing: 16) {
            Image(systemName: league.iconName)
                .font(.system(size: 24))
                .foregroundStyle(league.color)
            Text(league.name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(league.color)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 56)
    }

    // MARK: Block 3 — Bronze progress CTA

    private var bronzeBlock: some View {
        VStack(spacing: 0) {

            // Icon
            Image(systemName: "target")
                .font(.system(size: 40, weight: .regular))
                .foregroundStyle(bronzeColor)
                .frame(maxWidth: .infinity, alignment: .center)

            // Title
            Text("Попади в Bronze лигу")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.top, 12)

            // Subtitle
            Text("Сделай ещё 3 верных прогноза в Daily Flash")
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 8)

            // Progress bar
            VStack(alignment: .trailing, spacing: 6) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.10))
                            .frame(height: 8)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(bronzeColor)
                            .frame(width: geo.size.width * bronzeProgress, height: 8)
                    }
                }
                .frame(height: 8)

                Text("\(bronzeDone) / \(bronzeTotal)")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.textSecondary)
            }
            .padding(.top, 16)

            // CTA button
            Button {
                selectedTab = 0
            } label: {
                HStack(spacing: 8) {
                    Text("Перейти к прогнозам")
                        .font(.system(size: 16, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(bronzeColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)
            .padding(.top, 16)
        }
        .padding(20)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: Block 4 — Feature preview

    private var featuresBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Что ждёт в лигах")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)
                .padding(.bottom, 2)

            ForEach(features, id: \.icon) { feature in
                HStack(spacing: 12) {
                    Image(systemName: feature.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(AppTheme.accent)
                        .frame(width: 28)
                    Text(feature.text)
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.04))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal, 16)
    }
}
