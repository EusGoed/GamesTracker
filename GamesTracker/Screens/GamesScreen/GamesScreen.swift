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
                        await viewModel.loadGames()
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
                            await viewModel.loadGames()
                        }
                    }
                }
            .navigationTitle("Most recent games")
            
        }
    }
}
