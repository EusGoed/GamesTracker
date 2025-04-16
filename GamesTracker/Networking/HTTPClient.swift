//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import OSLog

class HTTPClient: Networkable {
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "",
        category: String(describing: HTTPClient.self)
    )
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(endpoint: any EndPoint) async throws -> T {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            HTTPClient.logger.warning("Could not create request: invalid URL")
            throw NetworkError.invalidURL
        }

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            HTTPClient.logger.warning("Could not create request: invalid URL")
            throw NetworkError.invalidURL
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            HTTPClient.logger.warning("Response is not an HTTPURLResponse")
            throw NetworkError.noResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            HTTPClient.logger.warning("Got a response with an unexpected status code: \(httpResponse.statusCode)")
            throw NetworkError.unexpectedStatusCode
        }

        do {
            return try JSONDecoder.snakeCaseDecoder.decode(T.self, from: data)
        } catch {
            HTTPClient.logger.error("Decoding failed: \(error.localizedDescription) - \(String(data: data, encoding: .utf8)!)")
            throw NetworkError.decodingError
        }
    }
}
