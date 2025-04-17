//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

struct MockImageLoadable: ImageLoadable {
    var imageId: String
    var imageURL: URL?
    var width: Double = 0
    var height: Double = 0
}

extension MockImageLoadable {
    static let validURL = MockImageLoadable(imageId: "1", imageURL: Bundle.main.url(forResource: "PreviewGameScreenshot", withExtension: "webp"))
    static let invalidURL = MockImageLoadable(imageId: "2", imageURL: URL(string: "https://www.google.com")!)
    static let coverURL = MockImageLoadable(imageId: "3", imageURL: Bundle.main.url(forResource: "PreviewGameCoverImage", withExtension: "webp"), width: 264, height: 352)
}
