//
//  ClientAssemblyTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import TeamWork

class ClientAssemblyTests: XCTestCase {
    
    func testSingleton() {
        let assembly1 = ClientAssembly.sharedAssembly
        let assembly2 = ClientAssembly.sharedAssembly
        XCTAssertTrue(assembly1 == assembly2)
    }
    
    func testClientManager() {
        let assembly = ClientAssembly.sharedAssembly
        var manager = assembly.getClientManager()
        XCTAssertTrue(manager is Client)
        
        let override = ClientManagerMock()
        assembly.clientManagerOverride = override
        manager = assembly.getClientManager()
        XCTAssertTrue(manager === override)
    }
}
