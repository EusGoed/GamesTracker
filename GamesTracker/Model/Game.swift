//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

struct GameDTO: Decodable, Identifiable, Sendable, Equatable {
    var id: Int
    var name: String
    var createdAt: Date
    var screenshots: [ImageLoadable]?
    var artworks: [ImageLoadable]?
    var url: URL
    var rating: Double?
    
    init(id: Int, name: String, createdAt: Date, screenshots: [ImageLoadable]? = nil, artworks: [ImageLoadable]? = nil, url: URL, rating: Double? = nil) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.screenshots = screenshots
        self.artworks = artworks
        self.url = url
        self.rating = rating
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case createdAt
        case screenshots
        case artworks
        case url
        case rating
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.createdAt = Date(timeIntervalSince1970: try container.decode(Double.self, forKey: .createdAt))
        self.screenshots = try container.decodeIfPresent([GameImage].self, forKey: .screenshots)
        self.artworks = try container.decodeIfPresent([GameImage].self, forKey: .artworks)
        self.url = try container.decode(URL.self, forKey: .url)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
    }
    
    static func == (lhs: GameDTO, rhs: GameDTO) -> Bool {
        lhs.id == rhs.id
    }
}
