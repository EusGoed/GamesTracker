//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftUI

@MainActor
protocol GamesScreenViewModel {
    var games: [GameDTO] { get set }
    func loadGames() async
}

@Observable
class GamesScreenDefaultViewModel: GamesScreenViewModel {
    var games: [GameDTO] = []
    
    private let dataLoader: GameDataLoading
    
    init(dataLoader: GameDataLoading) {
        self.dataLoader = dataLoader
    }
    
    func loadGames() async {
        do {
            let newGames = try await dataLoader.fetchGames(offset: games.count)
            withAnimation {
                games.append(contentsOf: newGames )
            }
        } catch {
            print(error)
        }
    }
}
