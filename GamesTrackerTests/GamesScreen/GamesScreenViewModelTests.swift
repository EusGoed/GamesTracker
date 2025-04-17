//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Testing
@testable import GamesTracker

@MainActor
struct GamesScreenViewModelTests {

    private let dataLoader: MockGameDataLoading
    
    private let sut: GamesScreenDefaultViewModel!
    
    init() {
        dataLoader = MockGameDataLoading()
        
        sut = GamesScreenDefaultViewModel(dataLoader: dataLoader)
    }
    
    @Test func loadGames_fetchesGames() async {
        // Arrange
        let mockGames = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        dataLoader.response = mockGames

        // Act
        await sut.loadGames()

        // Assert
        #expect(sut.games == mockGames)
    }
    
    @Test func loadGames_appendsGames() async {
        // Arrange
        let mockGames = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        dataLoader.response = [mockGames.first!]

        // Act
        await sut.loadGames()
        
        #expect(sut.games == [mockGames.first!] )
        
        // Arrange
        dataLoader.response = [mockGames.last!]

        // Act
        await sut.loadGames()
        
        // Assert
        #expect(sut.games == mockGames)
    }
    
    @Test func loadGames_forceRefresh_doesNotAppend() async {
        // Arrange
        let mockGames = [MockGameDTO.gameMario, MockGameDTO.gameZelda]
        dataLoader.response = mockGames

        // Act
        await sut.loadGames(forceRefresh: false)
        
        #expect(sut.games.count == 2 )
        
        // Arrange
        dataLoader.response = [mockGames.first!]

        // Act
        await sut.loadGames(forceRefresh: true)
        
        // Assert
        #expect(sut.games.count == 1)
    }
}
