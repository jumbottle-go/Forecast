import Foundation

struct AIAnalysis: Hashable, Codable {
    let summary: String
    let confidencePercent: Int
    let prosLabel: String
    let consLabel: String
    let pros: [String]
    let cons: [String]

    enum CodingKeys: String, CodingKey {
        case summary
        case confidencePercent = "confidencePercent"
        case prosLabel         = "prosLabel"
        case consLabel         = "consLabel"
        case pros
        case cons
    }
}

enum Category: String, CaseIterable, Identifiable, Hashable, Codable {
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

struct VoteOption: Identifiable, Hashable, Codable {
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

    enum CodingKeys: String, CodingKey {
        case id
        case iconName = "iconName"
        case text, subtitle, percent
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id       = (try? container.decode(UUID.self, forKey: .id)) ?? UUID()
        iconName = (try? container.decode(String.self, forKey: .iconName)) ?? "circle.fill"
        text     = try container.decode(String.self, forKey: .text)
        subtitle = (try? container.decode(String.self, forKey: .subtitle)) ?? ""
        percent  = (try? container.decode(Double.self, forKey: .percent)) ?? 0
    }
}

struct NewsItem: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageURL: String
    let source: String
    let publishedAt: Date
    let votesCount: Int
    let category: Category
    let isBreaking: Bool
    let isFlash: Bool
    let question: String
    let options: [VoteOption]
    let aiShortAnswer: String?
    let aiAnalysis: AIAnalysis?

    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: publishedAt, relativeTo: Date())
    }

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        imageURL: String,
        source: String,
        publishedAt: Date,
        votesCount: Int,
        category: Category,
        isBreaking: Bool = false,
        isFlash: Bool = false,
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
        self.publishedAt   = publishedAt
        self.votesCount    = votesCount
        self.category      = category
        self.isBreaking    = isBreaking
        self.isFlash       = isFlash
        self.question      = question
        self.options       = options
        self.aiShortAnswer = aiShortAnswer
        self.aiAnalysis    = aiAnalysis
    }

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, source, question, options
        case imageURL      = "image_url"
        case publishedAt   = "published_at"
        case votesCount    = "votes_count"
        case category
        case isBreaking    = "is_breaking"
        case isFlash       = "is_flash"
        case aiShortAnswer = "ai_short_answer"
        case aiAnalysis    = "ai_analysis"
    }

    static func == (lhs: NewsItem, rhs: NewsItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
