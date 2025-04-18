//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Testing
@testable import GamesTracker

@MainActor
struct GamesScreenViewModelTests {
    
    private let dataLoader: MockGameDataLoading!
    private let cachedDataManager: MockCachedDataManager!
    
    private let sut: GamesScreenDefaultViewModel!
    
    init() {
        dataLoader = MockGameDataLoading()
        cachedDataManager = MockCachedDataManager()
        
        sut = GamesScreenDefaultViewModel(dataLoader: dataLoader, cachedDataManager: cachedDataManager)
    }
    
    @Test func loadGames_callsSaveWithFetchedGames() async throws {
        // Arrange
        let expected = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        dataLoader.response = expected
        
        // Act
        await sut.loadGames(offset: 0)
        
        // Assert
        #expect(cachedDataManager.savedGames == expected)
    }
    
    @Test func deleteAllCachedData_callsDelete() async throws {
        // Act
        await sut.deleteAllCachedData()
        
        // Assert
        #expect(cachedDataManager.deleteCalled)
    }
    
    @Test func refresh_deletesThenLoads() async throws {
        // Arrange
        let expected = [MockGameDTO.gameZelda]
        dataLoader.response = expected
        
        // Act
        await sut.refresh()
        
        // Assert
        #expect(cachedDataManager.deleteCalled)
        #expect(cachedDataManager.savedGames == expected)
    }
    
    @Test func loadGames_handlesError() async {
        // Arrange
        dataLoader.error = MockError.testError
        
        // Act
        await sut.loadGames(offset: 0)
        
        // Assert
        #expect(cachedDataManager.savedGames.isEmpty)
    }
}
