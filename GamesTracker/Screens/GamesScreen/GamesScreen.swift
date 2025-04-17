//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI

struct GamesScreen: View {
    
    @State var viewModel: any GamesScreenViewModel
    
    var body: some View {
        if viewModel.games.isEmpty {
            ProgressView(label: {
                Text("Loading...")
                    .task {
                        await viewModel.loadGames(forceRefresh: false)
                    }
            })
        } else {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.games) { game in
                        NavigationLink {
                            GameDetailScreen(game: game)
                        } label: {
                            GameView(game: game)
                                .padding(.horizontal)
                        }
                    }
                    ProgressView()
                        .task {
                            await viewModel.loadGames(forceRefresh: false)
                        }
                    }
                }
            
            .refreshable {
                await viewModel.loadGames(forceRefresh: true)
            }
            .navigationTitle("Most recent games")
            
        }
    }
}
