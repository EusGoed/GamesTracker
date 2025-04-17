//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftUI

struct GamesScreen: View {
    
    @State var viewModel: any GamesScreenViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.games) { game in
                    GameView(game: game)
                        .padding(.horizontal)
                }
                ProgressView()
                    .task {
                        await viewModel.loadGames()
                    }
            }
        }
    }
}
