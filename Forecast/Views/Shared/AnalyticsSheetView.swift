import SwiftUI

struct AnalyticsSheetView: View {
    let analysis: AIAnalysis
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            VStack(spacing: 0) {
                // Handle
                Capsule()
                    .fill(AppTheme.border)
                    .frame(width: 40, height: 4)
                    .padding(.top, 10)
                    .padding(.bottom, 16)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        // Header + close button
                        HStack(alignment: .top) {
                            HStack(spacing: 10) {
                                Image(systemName: "sparkles")
                                    .font(.title2)
                                    .foregroundStyle(AppTheme.accent)
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("ИИ-Аналитика")
                                        .font(.headline)
                                        .foregroundStyle(AppTheme.textPrimary)
                                    Text(analysis.summary)
                                        .font(.subheadline)
                                        .foregroundStyle(AppTheme.accent)
                                }
                            }
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(AppTheme.textSecondary)
                            }
                            .buttonStyle(.plain)
                        }

                        // Pros block
                        proConBlock(
                            title: "Аргументы «За»",
                            items: analysis.pros,
                            icon: "checkmark.circle.fill",
                            color: AppTheme.success
                        )

                        // Cons block
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
