import Foundation

struct PredictionCard: Identifiable, Hashable {
    let id: UUID
    let question: String
    let imageURL: String
    let daysLeft: Int
    var yesPercent: Double
    var noPercent: Double
    let totalVotes: Int
    let aiAnalysis: String

    init(
        id: UUID = UUID(),
        question: String,
        imageURL: String,
        daysLeft: Int,
        yesPercent: Double,
        noPercent: Double,
        totalVotes: Int,
        aiAnalysis: String
    ) {
        self.id          = id
        self.question    = question
        self.imageURL    = imageURL
        self.daysLeft    = daysLeft
        self.yesPercent  = yesPercent
        self.noPercent   = noPercent
        self.totalVotes  = totalVotes
        self.aiAnalysis  = aiAnalysis
    }

    static func == (lhs: PredictionCard, rhs: PredictionCard) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
