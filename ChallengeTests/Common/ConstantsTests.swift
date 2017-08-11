//
//  ConstantsTests.swift
//  ChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import Challenge

class ConstantsTests: XCTestCase {
    func testDomainHasCorrectValue() {
        XCTAssertEqual(
            Constants.domain, "com.teamwork.yat"
        )
    }
}
