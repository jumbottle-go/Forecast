import SwiftUI

struct ProgressSegments: View {
    let total: Int
    let filled: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<total, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index < filled ? AppTheme.accent : AppTheme.border)
                    .frame(height: 3)
                    .animation(.easeInOut(duration: 0.3), value: filled)
            }
        }
    }
}
