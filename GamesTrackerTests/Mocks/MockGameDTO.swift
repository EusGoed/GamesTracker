//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
@testable import GamesTracker

struct MockGameDTO {
    static let gameZelda = GameDTO(id: 1, name: "Zelda", summary: "", createdAt: .now, url: URL(string: "https://example.com")!)
    static let gameMario = GameDTO(id: 2, name: "Mario", summary: "", createdAt: .now, url: URL(string: "https://example.com")!)
    
    private init() {}
}
