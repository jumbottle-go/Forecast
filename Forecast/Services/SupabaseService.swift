import Foundation
import Supabase

enum SupabaseServiceError: Error {
    case notSignedIn
}

final class SupabaseService {
    static let shared = SupabaseService()
    private init() {}

    let client = SupabaseClient(
        supabaseURL: URL(string: "https://pleeqadeufrmzfhmafec.supabase.co")!,
        supabaseKey: "sb_publishable_COKLuuETot4T-J5_1gOokg_IGMimDGb"
    )

    // MARK: Auth

    /// Signs in anonymously if no session exists yet.
    func ensureSignedIn() async throws {
        if client.auth.currentSession == nil {
            try await client.auth.signInAnonymously()
            print("👤 Анонимный вход выполнен")
        }
    }

    func currentUserId() throws -> UUID {
        guard let userId = client.auth.currentSession?.user.id else {
            throw SupabaseServiceError.notSignedIn
        }
        return userId
    }

    // MARK: News

    func fetchNewsItems() async throws -> [NewsItem] {
        let response = try await client
            .from("news_items")
            .select()
            .execute()

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            let withFractional = ISO8601DateFormatter()
            withFractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = withFractional.date(from: string) { return date }
            let withoutFractional = ISO8601DateFormatter()
            withoutFractional.formatOptions = [.withInternetDateTime]
            if let date = withoutFractional.date(from: string) { return date }
            throw DecodingError.dataCorruptedError(in: container,
                debugDescription: "Cannot decode date: \(string)")
        }
        return try decoder.decode([NewsItem].self, from: response.data)
    }

    // MARK: Votes

    /// Returns the list of news_item_ids the user has already voted on.
    func fetchVotedNewsItemIds(userId: UUID) async throws -> [UUID] {
        struct Row: Decodable {
            let newsItemId: UUID
            enum CodingKeys: String, CodingKey {
                case newsItemId = "news_item_id"
            }
        }
        let response = try await client
            .from("votes")
            .select("news_item_id")
            .eq("user_id", value: userId.uuidString)
            .execute()
        return try JSONDecoder().decode([Row].self, from: response.data).map { $0.newsItemId }
    }

    func saveVote(newsItemId: UUID, optionId: String) async throws {
        let userId = try currentUserId()
        struct Payload: Encodable {
            let newsItemId: UUID
            let optionId: String
            let userId: UUID
            enum CodingKeys: String, CodingKey {
                case newsItemId = "news_item_id"
                case optionId   = "option_id"
                case userId     = "user_id"
            }
        }
        do {
            try await client
                .from("votes")
                .insert(Payload(newsItemId: newsItemId, optionId: optionId, userId: userId))
                .execute()
        } catch {
            // Unique constraint 23505: user already voted for this item — safe to ignore
            if error.localizedDescription.contains("23505") {
                print("⚠️ Голос уже существует в БД (unique constraint) — игнорируем")
            } else {
                throw error
            }
        }
    }
}
