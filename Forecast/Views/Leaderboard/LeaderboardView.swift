import SwiftUI

struct LeaderboardView: View {

    @Binding var selectedTab: Int
    @State private var dotPulse = false

    // MARK: - Mock data

    private struct League {
        let iconName: String
        let name: String
        let color: Color
    }

    private let leagues: [League] = [
        League(iconName: "crown.fill",  name: "Diamond",  color: Color(hex: "B9F2FF")),
        League(iconName: "trophy.fill", name: "Platinum", color: Color(hex: "E5E4E2")),
        League(iconName: "medal.fill",  name: "Gold",     color: Color(hex: "FFD700")),
        League(iconName: "shield.fill", name: "Silver",   color: Color(hex: "C0C0C0")),
        League(iconName: "star.fill",   name: "Bronze",   color: Color(hex: "CD7F32"))
    ]

    private let bronzeColor = Color(hex: "CD7F32")
    private let grayLine    = Color.white.opacity(0.15)
    private let rowHeight: CGFloat = 48

    private struct FeatureCard {
        let icon: String
        let text: String
    }

    private let features: [FeatureCard] = [
        FeatureCard(icon: "chart.bar.fill",      text: "Соревнуйся с игроками твоего уровня"),
        FeatureCard(icon: "arrow.up.circle.fill", text: "Повышайся в лигах каждый месяц"),
        FeatureCard(icon: "flame.fill",           text: "Множители очков в высших лигах")
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

                    // Block 2 — Bronze progress
                    bronzeProgressBlock
                        .padding(.top, 0)

                    // Block 3 — League track
                    leagueTrackBlock
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

    // MARK: Block 2 — Bronze progress

    private var bronzeProgressBlock: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Icon + title row
            HStack(spacing: 12) {
                Image(systemName: "star.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(bronzeColor)
                Text("До Bronze лиги")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
            }

            // Subtitle
            Text("Сделай ещё 3 верных прогноза в Daily Flash")
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textSecondary)
                .padding(.top, 8)

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.10))
                        .frame(height: 8)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(bronzeColor)
                        .frame(width: geo.size.width * 0.4, height: 8)
                }
            }
            .frame(height: 8)
            .padding(.top, 14)

            Text("2 / 5")
                .font(.system(size: 12))
                .foregroundStyle(AppTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 6)

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
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: Block 3 — League track

    private var leagueTrackBlock: some View {
        VStack(spacing: 0) {
            ForEach(Array(leagues.enumerated()), id: \.offset) { idx, league in
                let isFirst  = idx == 0
                let isBronze = idx == leagues.count - 1
                leagueTrackRow(league, isFirst: isFirst, isBronze: isBronze)
            }
            calibrationRow
        }
        .padding(16)
        .background(Color.white.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // Regular league row
    @ViewBuilder
    private func leagueTrackRow(_ league: League, isFirst: Bool, isBronze: Bool) -> some View {
        HStack(spacing: 12) {

            // Track column: continuous line + dot
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(isFirst ? Color.clear : grayLine)
                        .frame(width: 2, height: rowHeight / 2)
                    Rectangle()
                        .fill(isBronze ? bronzeColor : grayLine)
                        .frame(width: 2, height: rowHeight / 2)
                }
                Circle()
                    .fill(isBronze ? bronzeColor : grayLine)
                    .frame(width: 10, height: 10)
            }
            .frame(width: 20, height: rowHeight)

            // League icon + name
            HStack(spacing: 10) {
                Image(systemName: league.iconName)
                    .font(.system(size: 20))
                    .foregroundStyle(league.color)
                Text(league.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(league.color)
            }
            .opacity(isBronze ? 1.0 : 0.3)
            .frame(maxWidth: .infinity, alignment: .leading)

            // Lock
            Image(systemName: "lock.fill")
                .font(.system(size: 14))
                .foregroundStyle(Color.white.opacity(0.25))
        }
        .frame(height: rowHeight)
    }

    // "You are here" calibration row
    private var calibrationRow: some View {
        HStack(spacing: 12) {

            // Track column: bronze top line + pulsating dot
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(bronzeColor)
                        .frame(width: 2, height: rowHeight / 2)
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 2, height: rowHeight / 2)
                }
                Circle()
                    .fill(bronzeColor)
                    .frame(width: 14, height: 14)
                    .opacity(dotPulse ? 1.0 : 0.5)
            }
            .frame(width: 20, height: rowHeight)

            Text("Калибровка")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(AppTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: rowHeight)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                dotPulse = true
            }
        }
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
