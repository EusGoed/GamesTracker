//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import Testing
@testable import GamesTracker

struct HTTPClientTests {

    struct DecodableResponse: Codable, Equatable {
        let message: String
    }
    
    private let urlSession: MockURLSession!
    private let authenticator: MockAuthenticator!
    private let endpoint: MockEndpoint!
    
    private let sut: HTTPClient!
    
    init() {
        urlSession = MockURLSession()
        authenticator = MockAuthenticator()
        endpoint = MockEndpoint()
        
        sut = HTTPClient(urlSession: urlSession, authenticator: authenticator)
    }
    
    // MARK: Unauthenticated
    @Test func sendRequest_successful() async throws {
        let expectedResponse = DecodableResponse(message: "testing")
        urlSession.data = [try! JSONEncoder().encode(expectedResponse)]
        urlSession.responses = [urlResponse(statusCode: 200)]

        let response: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)

        #expect(response == expectedResponse)
    }
    
    @Test func sendRequest_failed_unexpectedStatusCode() async {
        urlSession.data = [Data()]
        urlSession.responses = [urlResponse(statusCode: 500)]

        await #expect(throws: NetworkError.unexpectedStatusCode, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
    
    @Test func sendRequest_failed_noResponse() async {
        urlSession.data = [Data()]
        urlSession.responses = [URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 5, textEncodingName: nil)]

        await #expect(throws: NetworkError.noResponse, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
    
    @Test func sendRequest_failed_invalidURL() async {
        urlSession.data = [Data()]
        urlSession.responses = [urlResponse(statusCode: 200)]
        
        await #expect(throws: NetworkError.invalidURL, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: MockEndpoint(host: "testing.com/test"))
        })
    }

    @Test func sendRequest_failed_decodingError() async {
        urlSession.data = [Data()]
        urlSession.responses = [urlResponse(statusCode: 200)]

        await #expect(throws: NetworkError.decodingError, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
    
    // MARK: Authenticated
    @Test func sendRequest_unauthorized_success() async throws {
        await authenticator.setNewToken("refreshed-token")
        
        let expected = DecodableResponse(message: "authorized!")
        let encoded = try! JSONEncoder().encode(expected)

        urlSession.responses = [urlResponse(statusCode: 401), urlResponse(statusCode: 200)]
        urlSession.data = [Data(), encoded]

        let response: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)

        #expect(response == expected)
        #expect(await authenticator.refreshCalled)
    }
    
    @Test func sendRequest_unauthorized_failedRefresh() async {
        await authenticator.setShouldFailRefresh(true)

        urlSession.data = [Data()]
        urlSession.responses = [urlResponse(statusCode: 401)]

        await #expect(throws: NetworkError.unauthorized, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })

        #expect(await authenticator.refreshCalled)
    }
    
    private func urlResponse(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
