//
//  ClientAssembly.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation

/**
 Provider for Client request common functionality
 */
class ClientAssembly: NSObject {
    static let sharedAssembly = ClientAssembly()
    
    fileprivate override init(){}
    
    fileprivate let clientManager = Client()
    
    /** Custom provider for client */
    var clientManagerOverride : ClientManager? = nil
    
    /**
     Data access manager for client
     */
    func getClientManager() -> ClientManager {
        if let manager = clientManagerOverride {
            return manager
        }
        return clientManager
    }
}
