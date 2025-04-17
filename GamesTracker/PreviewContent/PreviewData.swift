//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

struct PreviewData {
    static let noScreenshotGame = GameDTO(id: 1, name: "Brand new game", createdAt: .now, url: .temporaryDirectory)
    static let screenshotGame = GameDTO(id: 1, name: "Brand new game", createdAt: .now, screenshots: [MockImageLoadable.validURL], url: .temporaryDirectory)
    static let loadingGame = GameDTO(id: 1, name: "Brand new game", createdAt: .now, screenshots: [MockImageLoadable.invalidURL], url: .temporaryDirectory)
}
