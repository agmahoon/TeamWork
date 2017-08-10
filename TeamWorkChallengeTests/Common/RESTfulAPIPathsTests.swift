//
//  RESTfulAPIPathsTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import TeamWorkChallenge

class RESTfulAPIPathsTests: XCTestCase {
    
    func testAllPathsAreCorrect() {
        XCTAssertEqual(
            RESTfulAPIPaths.baseURL, "https://yat.teamwork.com"
        )
        XCTAssertEqual(
            RESTfulAPIPaths.projectPath, "/projects.json"
        )
        XCTAssertEqual(
            RESTfulAPIPaths.tasklistPath, "/projects/{project_id}/tasklists.json"
        )
        XCTAssertEqual(
            RESTfulAPIPaths.taskPathOnTaskList, "/tasklists/{id}/tasks.json"
        )
        XCTAssertEqual(
            RESTfulAPIPaths.taskPathOnProject, "/projects/{id}/tasks.json"
        )
    }
}
