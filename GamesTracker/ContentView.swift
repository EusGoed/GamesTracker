//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
   
    private let dataLoader: GameDataLoader
    
    init() {
        let client = HTTPClient(authenticator: TwitchAuthenticator())
        self.dataLoader = GameDataLoader(client: client)
    }
    
    var body: some View {
        NavigationStack {
            GamesScreen(viewModel: GamesScreenDefaultViewModel(dataLoader: dataLoader))
        }
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
