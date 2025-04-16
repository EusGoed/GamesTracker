//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

enum TwitchEndpoint {
    case token
}

extension TwitchEndpoint: EndPoint {
    var host: String {
        "id.twitch.tv"
    }
    
    var path: String {
        switch self {
        case .token:
            "/oauth2/token"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .token:
            .post
        }
    }
    
    var queryParams: [String : String]? {
        ["client_id": Constants.twitchClientId, "client_secret": Constants.twitchClientSecret, "grant_type": "client_credentials"]
    }
}
