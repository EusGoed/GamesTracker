//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
