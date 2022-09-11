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

///This Class is used to determine the network avalablity
class Reachability {
    
    static let sharedInstance = Reachability()
    var networkPathMonitor = NWPathMonitor()
    weak var reachabilityDelegate: ReachabilityDelegate?
    
    /**
    This funtion to be called for startgin the network monitorng
     - Change in Netowrk status can be handled in networkStatusChanged callback
     */
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
    
    /// This function is to stop the network monitoring
    func stopNetworkMonitoring() {
        self.networkPathMonitor.cancel()
    }
    
    /**
     This funtion is to determine the network avalability
        - Bool value will be returned back
     */
    func isNetworkAvailable() -> Bool {
        if self.networkPathMonitor.currentPath.status == .satisfied {
            return true
        } else {
            return false
        }
    }
}
