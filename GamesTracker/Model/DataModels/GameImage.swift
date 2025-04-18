//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftData
@Model
final class GameImage {
    @Attribute(.unique) var imageId: String
    var height: Double
    var width: Double

    @Relationship(inverse: \Game.screenshots) var gameScreenshot: Game?
    @Relationship(inverse: \Game.artworks) var gameArtwork: Game?
    @Relationship(inverse: \Game.cover) var gameCover: Game?
    
    init(imageId: String, height: Double, width: Double) {
        self.imageId = imageId
        self.height = height
        self.width = width
    }
    
    init(from dto: ImageLoadable) {
        self.imageId = dto.imageId
        self.height = dto.height
        self.width = dto.width
    }
    
    func genericImage() -> GameGenericImage {
        GameGenericImage(imageId: imageId, height: height, width: width)
    }
    
    func coverImage() -> GameCoverImage {
        GameCoverImage(imageId: imageId, height: height, width: width)
    }
}
