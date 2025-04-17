//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

@testable import GamesTracker

final class MockGameDataLoading: GameDataLoading {
    var response: [GameDTO]?
    var error: Error?
    
    func fetchGames(offset: Int) async throws -> [GameDTO] {
        if let error {
            throw error
        }
        if let response {
            return response
        }
        fatalError("No error or response set!")
    }
}
