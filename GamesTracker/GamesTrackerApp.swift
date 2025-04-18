//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI
import SwiftData

@main
struct GamesTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Game.self, GameImage.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            let client = HTTPClient(authenticator: TwitchAuthenticator())
            let dataLoader = GameDataLoader(client: client)
            let cachedDataManager = CachedGameDataManager(modelContainer: sharedModelContainer)
            let viewModel = GamesScreenDefaultViewModel(dataLoader: dataLoader, cachedDataManager: cachedDataManager)
            NavigationStack {
                GamesScreen(viewModel: viewModel)
                    .modelContainer(sharedModelContainer)
                    .environment(networkMonitor)
            }
        }
    }
}
