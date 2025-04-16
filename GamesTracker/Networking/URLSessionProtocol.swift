//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
extension URLSession: URLSessionProtocol { }
