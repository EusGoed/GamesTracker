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
    private let authenticator: Authenticator
    
    init(urlSession: URLSessionProtocol = URLSession.shared, authenticator: Authenticator) {
        self.urlSession = urlSession
        self.authenticator = authenticator
    }
    
    func sendRequest<T: Decodable>(endpoint: any Endpoint, shouldRetryOnUnauthorized: Bool = true) async throws -> T {
        guard let urlRequest = createRequest(endPoint: endpoint, accessToken: await authenticator.accessToken) else {
            HTTPClient.logger.warning("Could not create request: invalid URL")
            throw NetworkError.invalidURL
        }

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            HTTPClient.logger.warning("Could not create request: invalid URL (\(urlRequest.url?.absoluteString ?? "-"))")
            throw NetworkError.invalidURL
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            HTTPClient.logger.warning("Response is not an HTTPURLResponse")
            throw NetworkError.noResponse
        }

        if httpResponse.statusCode == 401 {
            guard shouldRetryOnUnauthorized else {
                HTTPClient.logger.warning("Client is unauthorized")
                throw NetworkError.unauthorized
            }

            do {
                try await authenticator.refreshAccessToken()
            } catch {
                HTTPClient.logger.error("Token refresh failed: \(error.localizedDescription)")
                throw NetworkError.unauthorized
            }
            return try await sendRequest(endpoint: endpoint, shouldRetryOnUnauthorized: false)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            HTTPClient.logger.warning("Got a response with an unexpected status code: \(httpResponse.statusCode) - \(String(data: data, encoding: .utf8) ?? "Unknown")")
            throw NetworkError.unexpectedStatusCode
        }

        do {
            return try JSONDecoder.snakeCaseDecoder.decode(T.self, from: data)
        } catch {
            HTTPClient.logger.error("Decoding failed: \(error) - \(String(data: data, encoding: .utf8)!)")
            throw NetworkError.decodingError
        }
    }
}
