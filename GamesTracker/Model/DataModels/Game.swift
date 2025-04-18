//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftData

@Model
final class Game {
    @Attribute(.unique) var id: Int
    var name: String
    var summary: String?
    var createdAt: Date
    var url: URL
    var rating: Double?
    
    @Relationship(deleteRule: .cascade)
    var screenshots: [GameImage]?
    @Relationship(deleteRule: .cascade)
    var artworks: [GameImage]?
    @Relationship(deleteRule: .cascade)
    var cover: GameImage?
    
    init(id: Int, name: String, summary: String? = nil, createdAt: Date, screenshots: [GameImage]? = nil, artworks: [GameImage]? = nil, cover: GameImage? = nil, url: URL, rating: Double? = nil) {
        self.id = id
        self.name = name
        self.summary = summary
        self.createdAt = createdAt
        self.screenshots = screenshots
        self.artworks = artworks
        self.cover = cover
        self.url = url
        self.rating = rating
    }
    
    init(from dto: GameDTO) {
        self.id = dto.id
        self.name = dto.name
        self.summary = dto.summary
        self.createdAt = dto.createdAt
        self.screenshots = dto.screenshots?.map { GameImage(imageId: $0.imageId, height: $0.height, width: $0.width) }
        self.artworks = dto.artworks?.map { GameImage(imageId: $0.imageId, height: $0.height, width: $0.width) }
        self.cover = dto.cover.map { GameImage(imageId: $0.imageId, height: $0.height, width: $0.width) }
        self.url = dto.url
        self.rating = dto.rating
    }
}

