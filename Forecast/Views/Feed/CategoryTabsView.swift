import SwiftUI

struct CategoryTabsView: View {
    @Binding var selected: Category
    let onSelect: (Category) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Category.allCases) { category in
                    ChipButton(
                        category: category,
                        isSelected: selected == category
                    ) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selected = category
                        }
                        onSelect(category)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }
}

private struct ChipButton: View {
    let category: Category
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: category.symbol)
                    .font(.caption.bold())
                Text(category.rawValue)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color.white : AppTheme.card)
            .foregroundStyle(isSelected ? Color.black : AppTheme.textSecondary)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.chipRadius))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.chipRadius)
                    .strokeBorder(isSelected ? Color.clear : AppTheme.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
