//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

struct PreviewData {
    static let noScreenshotGame = GameDTO.previewGame(id: 1)
    static let screenshotGame = GameDTO.previewGame(id: 2, screenshots: [MockImageLoadable.validURL])
    static let loadingGame = GameDTO.previewGame(id: 3, screenshots: [MockImageLoadable.invalidURL])
    static let artworkGame = GameDTO.previewGame(id: 4, artworks: [MockImageLoadable.validURL])
    
    static let gameDetailGame = GameDTO.previewGame(id: 5, name: "Mario Kart World", summary: "Put the pedal to the metal in a vast interconnected environment. Race seamlessly across connected courses like never before. Participate in the new knockout tour elimination mode, where you’ll barrel through back-to-back courses and checkpoints. And in free roam, it’s possible to go off the racetrack and drive in any direction you wish, explore areas that pique your interest and take some photos at scenic spots with a group of friends.")
}
extension GameDTO {
    static func previewGame(
        id: Int,
        name: String? = nil,
        summary: String? = nil,
        createdAt: Date = .now,
        screenshots: [ImageLoadable] = [],
        artworks: [ImageLoadable] = [],
        cover: ImageLoadable? = MockImageLoadable.coverURL,
        url: URL = .temporaryDirectory,
        rating: Double? = 50.0
    ) -> GameDTO {
        GameDTO(
            id: id,
            name: name ?? "Preview Game #\(id)",
            summary: summary,
            createdAt: createdAt,
            screenshots: screenshots,
            artworks: artworks,
            cover: cover,
            url: url,
            rating: rating
        )
    }
}
