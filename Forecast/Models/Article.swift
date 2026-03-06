import Foundation

struct KeyFact: Identifiable, Hashable {
    let id: UUID
    let emoji: String
    let text: String

    init(id: UUID = UUID(), emoji: String, text: String) {
        self.id    = id
        self.emoji = emoji
        self.text  = text
    }
}

enum BodyElement: Identifiable, Hashable {
    case text(UUID, String)
    case image(UUID, String, String) // id, url, caption

    var id: UUID {
        switch self {
        case .text(let id, _):       return id
        case .image(let id, _, _):   return id
        }
    }

    static func == (lhs: BodyElement, rhs: BodyElement) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

struct Article: Identifiable, Hashable {
    let id: UUID
    let newsItem: NewsItem
    let keyFacts: [KeyFact]
    let bodyParagraphs: [BodyElement]
    let predictionQuestions: [PredictionCard]

    init(
        id: UUID = UUID(),
        newsItem: NewsItem,
        keyFacts: [KeyFact],
        bodyParagraphs: [BodyElement],
        predictionQuestions: [PredictionCard]
    ) {
        self.id                  = id
        self.newsItem            = newsItem
        self.keyFacts            = keyFacts
        self.bodyParagraphs      = bodyParagraphs
        self.predictionQuestions = predictionQuestions
    }

    static func == (lhs: Article, rhs: Article) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
