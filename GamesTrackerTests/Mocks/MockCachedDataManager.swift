//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

@testable import GamesTracker

final class MockCachedDataManager: CachedGameDataManaging {
    var savedGames: [GameDTO] = []
    var deleteCalled = false

    func save(_ games: [GameDTO]) async throws {
        savedGames = games
    }

    func deleteAllCachedData() async throws {
        deleteCalled = true
    }
}
