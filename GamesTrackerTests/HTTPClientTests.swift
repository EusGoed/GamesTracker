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
    private let endpoint: MockEndpoint!
    
    private let sut: HTTPClient!
    
    init() {
        urlSession = MockURLSession()
        endpoint = MockEndpoint()
        sut = HTTPClient(urlSession: urlSession)
    }

    @Test func sendRequest_successful() async throws {
        let expectedResponse = DecodableResponse(message: "testing")
        urlSession.data = try! JSONEncoder().encode(expectedResponse)
        urlSession.response = HTTPURLResponse(
            url: URL(string: "https://google.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        let response: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)

        #expect(response == expectedResponse)
    }
    
    @Test func sendRequest_failed_unexpectedStatusCode() async {
        urlSession.data = Data()
        urlSession.response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!

        await #expect(throws: NetworkError.unexpectedStatusCode, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
    
    @Test func sendRequest_failed_noResponse() async {
        urlSession.data = Data()
        urlSession.response = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 5, textEncodingName: nil)

        await #expect(throws: NetworkError.noResponse, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
    
    @Test func sendRequest_failed_invalidURL() async {
        urlSession.data = Data()
        urlSession.response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        await #expect(throws: NetworkError.invalidURL, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: MockEndpoint(host: "testing.com/test"))
        })
    }

    func sendRequest_failed_decodingError() async {
        urlSession.data = Data()
        urlSession.response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        await #expect(throws: NetworkError.decodingError, performing: {
            let _: DecodableResponse = try await sut.sendRequest(endpoint: endpoint)
        })
    }
}
