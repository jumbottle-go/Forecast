import Foundation

/// Describes a single @AppStorage flag: its UserDefaults key and default value.
struct AppFlag<Value> {
    let key: String
    let defaultValue: Value
}

/// Central registry of all app flags.
/// Add new flags here — key and default value in one place.
enum AppFlags {
    static let hasSeenOnboarding = AppFlag(key: "hasSeenOnboarding", defaultValue: 0)
    static let hasUserSwiped     = AppFlag(key: "hasUserSwiped",     defaultValue: false)

    /// Resets a flag to its default value in UserDefaults.
    static func reset<T>(_ flag: AppFlag<T>) {
        UserDefaults.standard.removeObject(forKey: flag.key)
    }

    /// Resets all registered flags.
    static func resetAll() {
        reset(hasSeenOnboarding)
        reset(hasUserSwiped)
    }
}

// MARK: - Notification names

extension Notification.Name {
    static let articleDismissedSwipe = Notification.Name("ArticleDismissedSwipe")
}
