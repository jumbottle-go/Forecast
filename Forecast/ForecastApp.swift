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

    var body: some View {
        TabView {
            FeedView()
                .environmentObject(feedViewModel)
                .tabItem {
                    Label("Лента", systemImage: "newspaper")
                }

            StubView(title: "Explore", icon: "safari")
                .tabItem {
                    Label("Explore", systemImage: "safari")
                }

            StubView(title: "Лидерборд", icon: "trophy")
                .tabItem {
                    Label("Лидерборд", systemImage: "trophy")
                }

            StubView(title: "Профиль", icon: "person.circle")
                .tabItem {
                    Label("Профиль", systemImage: "person.circle")
                }
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
