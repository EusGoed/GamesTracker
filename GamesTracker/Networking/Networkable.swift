//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

protocol Networkable {
    func sendRequest<T: Decodable>(endpoint: any Endpoint, shouldRetryOnUnauthorized: Bool) async throws -> T
}

extension Networkable {
    func createRequest(endPoint: Endpoint, accessToken: String? = nil) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path.hasPrefix("/") ? endPoint.path : "/" + endPoint.path

        
        if let queryParams = endPoint.queryParams {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        
        if let accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endPoint.body {
            request.httpBody = body.data(using: .utf8)
        }
        
        return request
    }
}
