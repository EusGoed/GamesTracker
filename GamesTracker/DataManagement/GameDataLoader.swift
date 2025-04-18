//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import OSLog

protocol GameDataLoading {
    func fetchGames(offset: Int) async throws -> [GameDTO]
}

actor GameDataLoader: GameDataLoading {
    private static let logger = Logger(for: GameDataLoader.self)
    
    private let client: Networkable
    
    init(client: Networkable) {
        self.client = client
    }
    
    func fetchGames(offset: Int) async throws -> [GameDTO] {
        do {
            return try await client.sendRequest(endpoint: IGDBEndpoint.games(.recentGames(offset: offset)), shouldRetryOnUnauthorized: true)
        } catch {
            GameDataLoader.logger.error("Error fetching games: \(error)")
            throw error
        }
    }
}
