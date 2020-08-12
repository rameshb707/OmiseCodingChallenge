//
//  NetworkReachability.swift
//  CharityDonationApp
//
//  Created by Ramesh B on 11/08/20.
//  Copyright © 2020 Ramesh B. All rights reserved.
//


import Foundation
import SystemConfiguration
import CoreTelephony

/// Defines the various states of network reachability.
///
///  - notReachable     :      The network is not reachable.
///  - reachableVia2G   :      Network Mode is 2G.
///  - reachableVia3G   :      Network Mode is 3G.
///  - reachableLTE4G   :      Network Mode is 4G.
///  - reachableViaWiFi :      Network Mode is Wifi.
///  - unknown          :      It is unknown whether the network is reachable.
public enum ReachabilityStatus {
    case notReachable
    case reachableViaMobileData
    case reachableViaWiFi
    case unkonwn
}

/**
   NetworkReachability class listens for reachability changes of hosts and addresses for both WWAN and WiFi network interfaces.
    A NetworkManager can listen to the changes of the state of network connection, to decide how it wants to schedule network requests.
    For example, when connectivity is lost, it might want to pause all the operations until
       the connection is established, or cancel all of them and retry when connection is established.
  */
public class NetworkReachability {

    // MARK: - private Properties

    private let reachability: SCNetworkReachability
    
    static let sharedInstance = NetworkReachability()

    /// Holds the Network Reachability flags
    private var flags: SCNetworkReachabilityFlags? {
        var flags = SCNetworkReachabilityFlags()

        if SCNetworkReachabilityGetFlags(reachability, &flags) {
            return flags
        }

        return nil
    }

    // MARK: - public Properties

    /// Whether the network is currently reachable.
    public var isReachable: Bool {
        return isReachableOnWWAN || isReachableOnEthernetOrWiFi
    }

    /// Whether the network is currently reachable over the WWAN interface.
    public var isReachableOnWWAN: Bool {
        return networkReachabilityStatus == .reachableViaMobileData
    }

    /// Whether the network is currently reachable over Ethernet or WiFi interface.
    public var isReachableOnEthernetOrWiFi: Bool {
        return networkReachabilityStatus == .reachableViaWiFi
    }

    /// The current network reachability status.
    public var networkReachabilityStatus: ReachabilityStatus {
        guard let flags = self.flags else { return .unkonwn }
        return networkReachabilityStatusForFlags(flags)
    }

    // MARK: - Initialization

    /**
       NetworkReachability instance with the specified SCNetworkReachability.Assignes the specified SCNetworkReachability to reachability variable

       - Parameters:
           - reachability: The host address which is monitered
    */
    private init(reachability: SCNetworkReachability) {
        self.reachability = reachability
    }

    /**
       Creates a NetworkReachability instance that monitors the address 0.0.0.0.

       - Returns: The new NetworkReachability instance.
    */
    public convenience init?() {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)

        guard let reachability = withUnsafePointer(to: &address, { pointer in
            pointer.withMemoryRebound(to: sockaddr.self, capacity: MemoryLayout<sockaddr>.size) {
                /// Reachability treats the 0.0.0.0 address as a special token that causes it to monitor the general routing
                return SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else { return nil }
        self.init(reachability: reachability)
    }
    

    private func networkReachabilityStatusForFlags(_ flags: SCNetworkReachabilityFlags) -> ReachabilityStatus {
        guard flags.contains(.reachable) else {
            return .notReachable
        }

        var networkStatus: ReachabilityStatus = .notReachable

        if flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic) || !flags.contains(.connectionRequired) {
            if !flags.contains(.interventionRequired) {
                networkStatus = networkReachableMode(reachable: flags)
            }
        }

        #if os(iOS)
            if flags.contains(.isWWAN) {
                networkStatus = networkReachableMode(reachable: flags)
            }
        #endif

        return networkStatus
    }

    /**
     Returns the network reachable mode like WWAN or Wifi
     */
    @discardableResult
    private func networkReachableMode(reachable flag: SCNetworkReachabilityFlags) -> ReachabilityStatus {
        if flag.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaMobileData
        } else if flag.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        } else if (flag.contains(.connectionOnDemand) == true || flag.contains(.connectionOnTraffic) == true) &&
            flag.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }

}
