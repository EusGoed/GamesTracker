//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Testing
@testable import GamesTracker

struct GameDataLoaderTests {
    
    private var client: MockNetworkable!
    
    private let sut: GameDataLoader!
    
    init() {
        client = MockNetworkable()
        
        sut = GameDataLoader(client: client)
    }
    
    @Test func fetchGames_returnsGames() async throws {
        // Arrange
        let mockGames = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        client.response = mockGames
        
        // Act
        let result = try await sut.fetchGames(offset: 0)

        // Assert
        #expect(result.map(\.id) == mockGames.map(\.id))
    }
    
    @Test func fetchGames_throwsError() async throws {
        // Arrange
        let mockGames = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        client.response = mockGames
        client.error = MockError.testError
        
        // Assert
        await #expect(throws: MockError.testError, performing: {
            
            // Act
            let _ = try await sut.fetchGames(offset: 0)
        })
    }
}
