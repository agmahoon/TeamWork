//
//  DateFormatterExtensionTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import TeamWorkChallenge

class DateFormatterExtensionTests: XCTestCase {
    
    func testDateFormatIsCorrect() {
        var givenFormatDate = "20141212"
        var requiredFormatDate = "2014-12-12"
        var resultantDate = givenFormatDate.convertDateFormater()
        XCTAssertEqual(
            resultantDate, requiredFormatDate
        )
        
        requiredFormatDate = "2014/12/12"
        XCTAssertNotEqual(
            resultantDate, requiredFormatDate
        )
        
        givenFormatDate = "2014/12/12"
        resultantDate = givenFormatDate.convertDateFormater()
        XCTAssertNotEqual(
            givenFormatDate, ""
        )
    }
}
