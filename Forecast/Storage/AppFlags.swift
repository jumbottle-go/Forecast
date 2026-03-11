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
}
