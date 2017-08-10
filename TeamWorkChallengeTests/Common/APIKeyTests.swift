//
//  APIKeyTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import TeamWorkChallenge

class APIKeyTests: XCTestCase {
    func testAPIKeyAndSecret() {
        XCTAssertEqual(
            APIKey.apiKey, "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
        )
        XCTAssertEqual(
            APIKey.apiPassword, "x"
        )
    }
}
