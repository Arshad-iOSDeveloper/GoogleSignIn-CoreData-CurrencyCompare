//
//  NetworkController.swift
//  FiveClaps
//
//  Created by Manoj MacMini12 on 06/11/15.
//  Copyright © 2015 Manoj MacMini12. All rights reserved.
//

import UIKit

private let _sharedNetworkController = NetworkController()
let kNetworkController = NetworkController.sharedInstance

class NetworkController: NSObject {
    
    let reachability: Reachability = Reachability.forInternetConnection()
    var hasInternetConnection: Bool = false
    
    // MARK: Singleton
    /* init */
    override init() {
        super.init()
        /* <#comment#> */
        startUp()
    }
    
    /* shared instance */
    class var sharedInstance: NetworkController {
        return _sharedNetworkController
    }
    
    func checkNetworkStatus() -> Bool {
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        hasInternetConnection = (networkStatus != NetworkStatus.NotReachable)
        if !hasInternetConnection {
            UIApplication.shared.endIgnoringInteractionEvents()
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(constants.no_internet.rawValue), object: nil)
            
            NotificationCenter.default.post(name: Notification.Name(constants.no_internet.rawValue), object: nil)
            
            // Utilities.showToastWithErrorMessage(message: Constants.no_internet.rawValue, duration: toastDuration)
            return false
        }
        
        return true
    }
    
    // MARK: Handle network status
    @objc func networkStatusDidChange(notification: NSNotification?) {
        let networkStatus: NetworkStatus = reachability.currentReachabilityStatus()
        hasInternetConnection = (networkStatus != NetworkStatus.NotReachable)
        
        if !hasInternetConnection {
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(constants.no_internet.rawValue), object: nil)
            
            NotificationCenter.default.post(name: Notification.Name(constants.no_internet.rawValue), object: nil)
            
        }
        else{
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(constants.yes_internet.rawValue), object: nil)
            
            NotificationCenter.default.post(name: Notification.Name(constants.yes_internet.rawValue), object: nil)
            
        }
    }
    
    // MARK: Functions
    
    /* call this once at init */
    func startUp() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkController.networkStatusDidChange(notification:)), name: NSNotification.Name.reachabilityChanged, object: nil)
        reachability.startNotifier()
    }
}
