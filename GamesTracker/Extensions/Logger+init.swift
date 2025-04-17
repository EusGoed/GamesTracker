//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import OSLog

extension Logger {
    init(for type: Any.Type) {
        self.init(
            subsystem: Bundle.main.bundleIdentifier ?? "",
            category: String(describing: type)
        )
    }
}
