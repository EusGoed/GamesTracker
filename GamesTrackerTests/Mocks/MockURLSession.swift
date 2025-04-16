//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
@testable import GamesTracker

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: NetworkError?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }

        guard let data, let response else {
            fatalError("Missing data and/or response")
        }

        return (data, response)
    }
}
