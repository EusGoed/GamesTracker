//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

typealias IGDBQuery = String

extension IGDBQuery {
    func fields(_ fields: [String]) -> IGDBQuery {
        let fields = "fields \(fields.joined(separator: ","));"
        return self.appending(fields)
    }
    
    func filters(_ filters: [String]) -> IGDBQuery {
        let filters = "where \(filters.joined(separator: " & "));"
        return self.appending(filters)
    }

    func sort(_ sort: String) -> IGDBQuery {
        let sort = "sort \(sort);"
        return self.appending(sort)
    }
    
    func limit(_ limit: Int) -> IGDBQuery {
        let limit = "limit \(limit);"
        return self.appending(limit)
    }
    
    func offset(_ offset: Int) -> IGDBQuery {
        let offset = "offset \(offset);"
        return self.appending(offset)
    }
}

extension IGDBQuery {
    static func recentGames() -> IGDBQuery {
        IGDBQuery()
            .fields(["name", "rating", "first_release_date", "screenshots.url", "total_rating", "url"])
            .filters(["first_release_date < \(Int(Date().timeIntervalSince1970))"])
            .sort("first_release_date desc")
            .limit(10)
    }
}
