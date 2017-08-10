//
//  JSONParserHelperTests.swift
//  TeamWorkTests
//
//  Created by Abdul Ghafoor on 10/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import TeamWork

class JSONParserHelperTests: XCTestCase {
    func testDataParsingIsCorrect() {
        let subject = JSONParserHelper()
        var parsedData = subject.parseJSON("projects")
        XCTAssertTrue(parsedData?["projects"].count == 2)
        
        parsedData = subject.parseJSON("tasklist")
        XCTAssertTrue(parsedData?["tasklists"].count == 2)
        
        parsedData = subject.parseJSON("dummy")
        XCTAssertNil(parsedData)
    }
}
