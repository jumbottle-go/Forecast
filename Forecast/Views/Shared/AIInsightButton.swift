import SwiftUI

struct AIInsightButton: View {
    let shortAnswer: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                Text("AI: \(shortAnswer)")
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Image(systemName: "chevron.right")
                    .font(.caption2.bold())
                    .opacity(0.8)
            }
            .font(.caption.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(
                        Color(white: 0.15)
                            .shadow(.inner(color: .black.opacity(0.9), radius: 3, x: 0, y: 3))
                            .shadow(.inner(color: .white.opacity(0.2), radius: 2, x: 0, y: -1))
                    )
            )
            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}
