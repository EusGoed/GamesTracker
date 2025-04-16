//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

protocol Authenticator {
    var accessToken: String? { get async }
    func refreshAccessToken() async throws
}

actor TwitchAuthenticator: Authenticator {
    private(set) var accessToken: String?

    func refreshAccessToken() async throws {
        let response: TokenResponse = try await HTTPClient(authenticator: self).sendRequest(endpoint: TwitchEndpoint.token, shouldRetryOnUnauthorized: false)
        accessToken = response.accessToken
    }
}
