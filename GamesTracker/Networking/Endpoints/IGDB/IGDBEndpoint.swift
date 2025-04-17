//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

enum IGDBEndpoint {
    case games(IGDBQuery)
}

extension IGDBEndpoint: Endpoint {
    var host: String {
        "api.igdb.com"
    }
    
    var path: String {
        let path: String
        switch self {
        case .games:
            path = "/games"
        }
        
        return apiVersion + path
    }
    
    var apiVersion: String {
        "v4"
    }
    
    var method: HTTPMethod {
        switch self {
        case .games:
            .post
        }
    }
    
    var header: [String : String]? {
        ["Client-ID": Constants.twitchClientId,
         "Accept": "application/json"]
    }
    
    var body: String? {
        switch self {
        case .games(let query):
            return query
        }
    }
}
