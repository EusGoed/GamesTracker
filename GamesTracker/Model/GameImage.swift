//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

protocol ImageLoadable: Decodable, Sendable {
    var imageURL: URL? { get }
}

struct GameImage: ImageLoadable {
    let imageId: String
    
    var imageURL: URL? {
        URL(string: "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).webp")
    }
}

