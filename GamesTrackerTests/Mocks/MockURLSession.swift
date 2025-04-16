//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
@testable import GamesTracker

final class MockURLSession: URLSessionProtocol {
    var data: [Data] = []
    var responses: [URLResponse] = []

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if !data.isEmpty, !responses.isEmpty {
            return (data.removeFirst(), responses.removeFirst())
        } else if let data = data.first, let response = responses.first {
            return (data, response)
        } else {
            fatalError("No mock response set.")
        }
    }
}
