import SwiftUI

@main
struct ForecastApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @StateObject private var feedViewModel = FeedViewModel()
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .environmentObject(feedViewModel)
                .tabItem { Label("Лента", systemImage: "newspaper") }
                .tag(0)

            StubView(title: "Explore", icon: "safari")
                .tabItem { Label("Explore", systemImage: "safari") }
                .tag(1)

            LeaderboardView(selectedTab: $selectedTab)
                .tabItem { Label("Лидерборд", systemImage: "trophy") }
                .tag(2)

            ProfileView()
                .tabItem { Label("Профиль", systemImage: "person.circle") }
                .tag(3)
        }
        .tint(AppTheme.accent)
        .preferredColorScheme(.dark)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(AppTheme.bg)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct StubView: View {
    let title: String
    let icon: String

    var body: some View {
        ZStack {
            AppTheme.bg.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 48))
                    .foregroundStyle(AppTheme.textSecondary)
                Text(title)
                    .font(.title2.bold())
                    .foregroundStyle(AppTheme.textPrimary)
                Text("Скоро")
                    .font(.subheadline)
                    .foregroundStyle(AppTheme.textSecondary)
            }
        }
    }
}
