//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftUI

@MainActor
protocol GamesScreenViewModel {
    var games: [GameDTO] { get set }
    func loadGames(forceRefresh: Bool) async
}

@Observable
class GamesScreenDefaultViewModel: GamesScreenViewModel {
    var games: [GameDTO] = []
    
    private let dataLoader: GameDataLoading
    
    init(dataLoader: GameDataLoading) {
        self.dataLoader = dataLoader
    }
    
    func loadGames(forceRefresh: Bool = false) async {
        do {
            let newGames = try await dataLoader.fetchGames(offset: forceRefresh ? 0 : games.count)
            withAnimation {
                if forceRefresh {
                    games = newGames // Empty games array and start fresh
                } else {
                    games.append(contentsOf: newGames )
                }
            }
        } catch {
            // Deal with error
        }
    }
}
