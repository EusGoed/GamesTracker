//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftUI
import OSLog

@MainActor
protocol GamesScreenViewModel {
    func loadGames(offset: Int) async
    func deleteAllCachedData() async
    func refresh() async
}

@Observable
class GamesScreenDefaultViewModel: GamesScreenViewModel {
    
    private static let logger = Logger(for: GamesScreenDefaultViewModel.self)
    private let dataLoader: GameDataLoading
    private let cachedDataManager: CachedGameDataManaging
    
    init(dataLoader: GameDataLoading, cachedDataManager: CachedGameDataManaging) {
        self.dataLoader = dataLoader
        self.cachedDataManager = cachedDataManager
    }
    
    func loadGames(offset: Int) async {
        do {
            let newGames = try await dataLoader.fetchGames(offset: offset)
            try await cachedDataManager.save(newGames)
        } catch {
            GamesScreenDefaultViewModel.logger.error("Error loading new games: \(error)")
        }
    }
    
    func deleteAllCachedData() async {
        do {
            try await cachedDataManager.deleteAllCachedData()
        } catch {
            GamesScreenDefaultViewModel.logger.error( "Error deleting cached data: \(error)")
        }
    }
    
    func refresh() async {
        await deleteAllCachedData()
        await loadGames(offset: 0)
    }
}
