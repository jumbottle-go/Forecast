import SwiftUI

struct CategoryBadge: View {
    let symbol: String
    let name: String

    init(symbol: String, name: String) {
        self.symbol = symbol
        self.name   = name
    }

    init(category: Category) {
        self.symbol = category.symbol
        self.name   = category.rawValue
    }

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: symbol)
                .font(.caption2.bold())
            Text(name)
                .font(.caption.bold())
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(.black.opacity(0.4))
        .clipShape(Capsule())
    }
}
