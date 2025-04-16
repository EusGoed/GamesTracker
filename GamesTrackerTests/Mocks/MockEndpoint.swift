//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
@testable import GamesTracker

struct MockEndpoint: EndPoint {
    var host: String
    var path: String
    var method: HTTPMethod
    
    init(host: String? = nil, path: String? = nil, method: HTTPMethod? = nil){
        self.host = host ?? "google.com"
        self.path = path ?? "/images"
        self.method = method ?? .get
    }
}
