//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

protocol ImageLoadable: Decodable, Sendable {
    var imageId: String { get }
    var imageURL: URL? { get }
    var height: Double { get }
    var width: Double { get }
}

struct GameGenericImage: ImageLoadable {
    let imageId: String
    let height: Double
    let width: Double
    
    var imageURL: URL? {
        URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).webp")
    }
}

struct GameCoverImage: ImageLoadable {
    let imageId: String
    let height: Double
    let width: Double
    
    var imageURL: URL? {
        URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(imageId).webp")
    }
}
