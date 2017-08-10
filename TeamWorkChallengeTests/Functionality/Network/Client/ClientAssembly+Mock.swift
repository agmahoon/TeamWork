//
//  ClientAssembly+Mock.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
@testable import TeamWorkChallenge

extension ClientAssembly {
    
    /**
     The assembly's mock client manager. Garanteed to be set as long as you have called `configureMocks` and not cleared the property in your own code.
     */
    var clientManagerMock : ClientManagerMock? {
        get {
            return clientManagerOverride as? ClientManagerMock
        }
    }
    
    /**
     Configure this instance for mocking backend services.
     */
    func configureMocks() {
        clientManagerOverride = ClientManagerMock()
    }
    
    /**
     Clear mock configure this instance.
     */
    func resetMocks() {
        clientManagerOverride = nil
    }
}
