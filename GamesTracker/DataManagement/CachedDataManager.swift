//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import SwiftData
import OSLog

protocol CachedGameDataManaging {
    func save(_ games: [GameDTO]) async throws
    func deleteAllCachedData() async throws
}

@ModelActor
actor CachedGameDataManager: CachedGameDataManaging {
    private static var logger = Logger(for: CachedGameDataManager.self)
    
    func save(_ games: [GameDTO]) async throws {
        for dto in games {
            modelContext.insert(Game(from: dto ))
        }
        CachedGameDataManager.logger.info("Saving \(games.count) games")
        try modelContext.save()
    }
    
    func deleteAllCachedData() async throws {
        CachedGameDataManager.logger.info("Deleting all games")
        try modelContext.delete(model: Game.self)
    }
}
