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
                .tabItem { Label("Лента", systemImage: "doc.text.image") }
                .tag(0)

            LeaderboardView(selectedTab: $selectedTab)
                .tabItem { Label("Лидерборд", systemImage: "trophy.fill") }
                .tag(1)

            ProfileView()
                .tabItem { Label("Профиль", systemImage: "person.fill") }
                .tag(2)
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
