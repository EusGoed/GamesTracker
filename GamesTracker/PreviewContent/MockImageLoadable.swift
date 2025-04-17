//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation

struct MockImageLoadable: ImageLoadable {
    var imageURL: URL?
    
}
extension MockImageLoadable {
    static let validURL = MockImageLoadable(imageURL: Bundle.main.url(forResource: "PreviewGameScreenshot", withExtension: "webp"))
    static let invalidURL = MockImageLoadable(imageURL: URL(string: "https://www.google.com")!)
}
