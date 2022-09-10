//
//  Reachability.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import Foundation
import Network

typealias NetworkPathMonitor = NWPathMonitor

protocol ReachabilityDelegate: NSObjectProtocol {
    func networkStatusChanged(isConnected: Bool)
}

class Reachability {
    
    static let sharedInstance = Reachability()
    var networkPathMonitor = NWPathMonitor()
    weak var reachabilityDelegate: ReachabilityDelegate?
    
    func startNetworkMonitoring() {
        let queue = DispatchQueue(label: "NetworkMonitoring")
        self.networkPathMonitor.pathUpdateHandler = { [weak self] (path) in
            if self?.networkPathMonitor.currentPath.status == .satisfied {
                self?.reachabilityDelegate?.networkStatusChanged(isConnected: true)
            } else {
                self?.reachabilityDelegate?.networkStatusChanged(isConnected: false)
            }
        }
        self.networkPathMonitor.start(queue: queue)
    }
    
    func stopNetworkMonitoring() {
        self.networkPathMonitor.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        if self.networkPathMonitor.currentPath.status == .satisfied {
            return true
        } else {
            return false
        }
    }
}
