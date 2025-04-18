//
// Copyright © 2025 Eus Goed.
// All Rights Reserved

import Foundation
import Network
import SwiftUI

/// Source : https://medium.com/@desilio/how-to-check-internet-connection-with-swiftui-9426454027f5
@Observable
final class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}

struct NoNetworkConnectionView: View {
    var body: some View {
        HStack {
            Image(systemName: "network.slash")
            Text("No connection to the internet. \nData you see might not be up to date.")

        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red)
        .cornerRadius(8)
    }
}
