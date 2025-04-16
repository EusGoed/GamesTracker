//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
@testable import GamesTracker

final actor MockAuthenticator: Authenticator {
    private(set) var accessToken: String? = "token"
    private(set) var refreshCalled = false
    private(set) var shouldFailRefresh = false
    private(set) var newToken: String?

    func refreshAccessToken() async throws {
        refreshCalled = true
        if shouldFailRefresh {
            throw NetworkError.unauthorized
        }
        accessToken = newToken
    }
    
    func setNewToken(_ newToken: String) {
        self.newToken = newToken
    }
    
    func setShouldFailRefresh(_ shouldFailRefresh: Bool) {
        self.shouldFailRefresh = shouldFailRefresh
    }
}
