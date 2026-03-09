import Foundation

struct AIAnalysis: Hashable {
    let summary: String
    let pros: [String]
    let cons: [String]
}

enum Category: String, CaseIterable, Identifiable, Hashable {
    case forYou   = "For You"
    case finance  = "Finance"
    case tech     = "Tech"
    case politics = "Politics"
    case sports   = "Sports"
    case science  = "Science"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .forYou:   return "star.fill"
        case .finance:  return "chart.line.uptrend.xyaxis"
        case .tech:     return "desktopcomputer"
        case .politics: return "building.columns"
        case .sports:   return "sportscourt"
        case .science:  return "atom"
        }
    }
}

struct VoteOption: Identifiable, Hashable {
    let id: UUID
    let iconName: String
    let text: String
    let subtitle: String
    var percent: Double

    init(id: UUID = UUID(), iconName: String, text: String, subtitle: String, percent: Double) {
        self.id       = id
        self.iconName = iconName
        self.text     = text
        self.subtitle = subtitle
        self.percent  = percent
    }
}

struct NewsItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageURL: String
    let source: String
    let timeAgo: String
    let votesCount: Int
    let category: Category
    let isBreaking: Bool
    let question: String
    let options: [VoteOption]
    let aiShortAnswer: String?
    let aiAnalysis: AIAnalysis?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        imageURL: String,
        source: String,
        timeAgo: String,
        votesCount: Int,
        category: Category,
        isBreaking: Bool = false,
        question: String,
        options: [VoteOption],
        aiShortAnswer: String? = nil,
        aiAnalysis: AIAnalysis? = nil
    ) {
        self.id            = id
        self.title         = title
        self.subtitle      = subtitle
        self.imageURL      = imageURL
        self.source        = source
        self.timeAgo       = timeAgo
        self.votesCount    = votesCount
        self.category      = category
        self.isBreaking    = isBreaking
        self.question      = question
        self.options       = options
        self.aiShortAnswer = aiShortAnswer
        self.aiAnalysis    = aiAnalysis
    }

    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
