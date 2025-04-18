//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI
import SwiftData

struct GamesScreen: View {
    @State var viewModel: any GamesScreenViewModel
    @Environment(\.modelContext) var modelContext
    @Environment(NetworkMonitor.self) private var networkMonitor
    
    @Query(sort: \Game.createdAt, order: .reverse) private var games: [Game]
    
    var body: some View {
        VStack {
            if !networkMonitor.isConnected {
                NoNetworkConnectionView()
                    .padding(.horizontal)
            }
            if games.isEmpty {
                ProgressView(label: {
                    Text("Loading...")
                })
                .onChange(of: networkMonitor.isConnected, { _, newValue in
                    if newValue {
                        Task {
                            await viewModel.loadGames(offset: 0)
                        }
                    }
                })
                .task {
                    await viewModel.loadGames(offset: 0)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(games) { game in
                            NavigationLink {
                                GameDetailScreen(game: game)
                                    .environment(networkMonitor)
                            } label: {
                                GameView(game: game, isConnected: networkMonitor.isConnected)
                                    .padding(.horizontal)
                            }
                        }
                        ProgressView()
                            .task {
                                await viewModel.loadGames(offset: games.count)
                            }
                    }
                }
                .refreshable {
                    await viewModel.refresh()
                }
                .navigationTitle("Most recent games")
            }
        }
    }
}
