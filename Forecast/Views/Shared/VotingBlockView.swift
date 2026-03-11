import SwiftUI

struct VotingBlockView: View {
    let question: String
    let options: [VoteOption]
    let votesCount: Int
    let votedOptionId: UUID?
    let onVote: (VoteOption) -> Void

    private var isVoted: Bool { votedOptionId != nil }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question)
                .font(.subheadline.bold())
                .foregroundStyle(AppTheme.textPrimary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            let colors: [Color] = [AppTheme.success, AppTheme.danger]
            HStack(spacing: 8) {
                ForEach(Array(options.prefix(2).enumerated()), id: \.element.id) { idx, option in
                    VoteButton(
                        option: option,
                        isSelected: votedOptionId == option.id,
                        isVoted: isVoted,
                        showSubtitle: false,
                        tintColor: idx < colors.count ? colors[idx] : AppTheme.accent
                    ) {
                        if !isVoted {
                            onVote(option)
                        }
                    }
                }
            }

            HStack(spacing: 4) {
                Image(systemName: "person.2.fill")
                Text("\(votesCount.formatted()) votes")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
