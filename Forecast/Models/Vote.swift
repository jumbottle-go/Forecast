import Foundation

struct Vote: Codable {
    let id: UUID?
    let newsItemId: UUID
    let optionId: String
    let userId: UUID?

    enum CodingKeys: String, CodingKey {
        case id
        case newsItemId = "news_item_id"
        case optionId   = "option_id"
        case userId     = "user_id"
    }
}
