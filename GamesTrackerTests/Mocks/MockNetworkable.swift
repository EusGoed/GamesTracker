//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

@testable import GamesTracker

final class MockNetworkable: Networkable {
    
    var response: Decodable?
    var error: Error?
    
    func sendRequest<T: Decodable>(endpoint: any Endpoint, shouldRetryOnUnauthorized: Bool) async throws -> T {
        if let error {
            throw error
        }
        if let response {
            return response as! T
        }
        fatalError("No error or response set!")
    }
}
