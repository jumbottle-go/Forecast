import SwiftUI

struct AnalyticsSheetView: View {
    let analysis: AIAnalysis

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Handle
                    Capsule()
                        .fill(AppTheme.border)
                        .frame(width: 40, height: 4)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)

                    // Header
                    HStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .font(.title2)
                            .foregroundStyle(AppTheme.accent)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("ИИ-Аналитика")
                                .font(.headline)
                                .foregroundStyle(AppTheme.textPrimary)
                            Text(analysis.summary)
                                .font(.subheadline)
                                .foregroundStyle(AppTheme.accent)
                        }
                    }

                    // Why Yes
                    proConBlock(
                        title: "Аргументы «За»",
                        items: analysis.pros,
                        icon: "checkmark.circle.fill",
                        color: AppTheme.success
                    )

                    // Why No
                    proConBlock(
                        title: "Аргументы «Против»",
                        items: analysis.cons,
                        icon: "xmark.circle.fill",
                        color: AppTheme.danger
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }

    @ViewBuilder
    private func proConBlock(title: String, items: [String], icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.subheadline.bold())
                .foregroundStyle(color)

            ForEach(items, id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: icon)
                        .font(.subheadline)
                        .foregroundStyle(color)
                    Text(item)
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                .strokeBorder(color.opacity(0.25), lineWidth: 1)
        )
    }
}
