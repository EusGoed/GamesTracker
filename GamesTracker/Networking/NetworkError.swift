//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unexpectedStatusCode
    case noResponse
    case decodingError
}
