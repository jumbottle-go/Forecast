import SwiftUI

struct VoteButton: View {
    let option: VoteOption
    let isSelected: Bool
    let isVoted: Bool
    let showSubtitle: Bool
    let onTap: () -> Void

    init(option: VoteOption,
         isSelected: Bool,
         isVoted: Bool,
         showSubtitle: Bool = false,
         onTap: @escaping () -> Void) {
        self.option      = option
        self.isSelected  = isSelected
        self.isVoted     = isVoted
        self.showSubtitle = showSubtitle
        self.onTap       = onTap
    }

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .leading) {
                // fill bar (voted state)
                if isVoted {
                    GeometryReader { geo in
                        Rectangle()
                            .fill(fillColor.opacity(0.18))
                            .frame(width: geo.size.width * option.percent / 100)
                            .animation(.easeOut(duration: 0.6), value: isVoted)
                    }
                }

                HStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 6) {
                            Image(systemName: option.iconName)
                                .foregroundStyle(textColor)
                            Text(option.text)
                                .fontWeight(.semibold)
                                .foregroundStyle(textColor)
                                .lineLimit(1)
                                .minimumScaleFactor(0.72)
                                .allowsTightening(true)
                        }
                        .font(.subheadline)

                        if showSubtitle {
                            Text(option.subtitle)
                                .font(.caption)
                                .foregroundStyle(AppTheme.textSecondary)
                                .lineLimit(1)
                        }
                    }

                    Spacer(minLength: 0)

                    Text("\(Int(option.percent))%")
                        .font(.subheadline.bold())
                        .foregroundStyle(fillColor)
                        .opacity(isVoted ? 1 : 0)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, showSubtitle ? 12 : 10)
            }
        }
        .buttonStyle(.plain)
        .background(buttonBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.buttonRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.buttonRadius)
                .strokeBorder(borderColor, lineWidth: isSelected ? 1.5 : 1)
        )
        .opacity(isVoted && !isSelected ? 0.55 : 1.0)
        .animation(.easeOut(duration: 0.3), value: isSelected)
        .animation(.easeOut(duration: 0.3), value: isVoted)
    }

    private var fillColor: Color {
        isSelected ? AppTheme.accent : AppTheme.textSecondary
    }

    private var textColor: Color {
        isSelected ? AppTheme.accent : AppTheme.textPrimary
    }

    private var borderColor: Color {
        isSelected ? AppTheme.accent : AppTheme.border
    }

    private var buttonBackground: Color {
        isSelected ? AppTheme.accent.opacity(0.15) : AppTheme.card
    }
}
