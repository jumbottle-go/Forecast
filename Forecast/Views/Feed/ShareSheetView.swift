import SwiftUI

struct ShareSheetView: View {
    let chosenOption: VoteOption?
    let topicTitle: String
    @Binding var isPresented: Bool

    @State private var comment: String = ""
    private let maxChars = 280

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Handle
                    Capsule()
                        .fill(AppTheme.border)
                        .frame(width: 40, height: 4)
                        .padding(.top, 8)

                    // Header
                    HStack(spacing: 10) {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundStyle(AppTheme.accent)
                        Text("Share your prediction!")
                            .font(.headline)
                            .foregroundStyle(AppTheme.textPrimary)
                    }

                    // Preview widget
                    HStack(spacing: 14) {
                        // App icon placeholder
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppTheme.accent)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Forecast")
                                .font(.caption)
                                .foregroundStyle(AppTheme.textSecondary)
                            if let option = chosenOption {
                                Label(option.text, systemImage: option.iconName)
                                    .font(.subheadline.bold())
                                    .foregroundStyle(AppTheme.accent)
                            }
                            Text(topicTitle)
                                .font(.caption)
                                .foregroundStyle(AppTheme.textPrimary)
                                .lineLimit(2)
                        }
                        Spacer()
                    }
                    .padding(14)
                    .background(AppTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                            .strokeBorder(AppTheme.border, lineWidth: 1)
                    )

                    // Comment field
                    VStack(alignment: .trailing, spacing: 6) {
                        ZStack(alignment: .topLeading) {
                            if comment.isEmpty {
                                Text("My comment...")
                                    .foregroundStyle(AppTheme.textSecondary)
                                    .padding(10)
                                    .allowsHitTesting(false)
                            }
                            TextEditor(text: $comment)
                                .scrollContentBackground(.hidden)
                                .foregroundStyle(AppTheme.textPrimary)
                                .frame(minHeight: 80)
                                .padding(6)
                                .onChange(of: comment) { _, new in
                                    if new.count > maxChars {
                                        comment = String(new.prefix(maxChars))
                                    }
                                }
                        }
                        .background(AppTheme.card)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                                .strokeBorder(AppTheme.border, lineWidth: 1)
                        )

                        Text("\(comment.count)/\(maxChars)")
                            .font(.caption)
                            .foregroundStyle(comment.count > maxChars - 20 ? AppTheme.danger : AppTheme.textSecondary)
                    }

                    // Share buttons
                    HStack(spacing: 20) {
                        ShareCircle(symbol: "x.circle.fill",       label: "X")
                        ShareCircle(symbol: "paperplane.fill",      label: "Telegram")
                        ShareCircle(symbol: "message.fill",         label: "WhatsApp")
                        ShareCircle(symbol: "doc.on.doc.fill",      label: "Copy")
                    }
                    .onTapGesture { isPresented = false }

                    // Skip
                    Button {
                        isPresented = false
                    } label: {
                        Text("Skip")
                            .font(.subheadline)
                            .foregroundStyle(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
            }
        }
        .onTapGesture { isPresented = false }
        .presentationDetents([.medium])
        .presentationDragIndicator(.hidden)
    }
}

private struct ShareCircle: View {
    let symbol: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            Circle()
                .fill(AppTheme.card)
                .frame(width: 54, height: 54)
                .overlay(
                    Image(systemName: symbol)
                        .font(.title3)
                        .foregroundStyle(AppTheme.accent)
                )
                .overlay(
                    Circle().strokeBorder(AppTheme.border, lineWidth: 1)
                )
            Text(label)
                .font(.caption2)
                .foregroundStyle(AppTheme.textSecondary)
        }
    }
}
