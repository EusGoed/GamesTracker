//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: String? { get }
    var queryParams: [String: String]? { get }
    var pathParams: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var header: [String: String]? {
        nil
    }
    
    var body: String? {
        nil
    }
    
    var queryParams: [String: String]? {
        nil
    }
    
    var pathParams: [String: String]? {
        nil
    }
}



