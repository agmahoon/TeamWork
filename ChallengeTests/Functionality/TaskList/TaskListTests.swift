//
//  TaskListTests.swift
//  ChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import Challenge

class TaskListTests: XCTestCase {
    
    func testPropertiesAreSetForTaskList() {
        let tasklist = TaskList(
            uncompletedCount: 10,
            complete: true,
            id: "28932",
            name: "name",
            description: "description"
        )
        var tasklist2 = tasklist
        XCTAssertEqual(tasklist.description, tasklist2.description)
        
        tasklist2.description = "New Description"
        XCTAssertNotEqual(tasklist.description, tasklist2.description)
    }
    
    func testTaskListProperiesAreMappleWithJSON() {
        let parser = JSONParserHelper()
        let tasklistData = parser.parseJSON("tasklist")
        
        if let tasklist = tasklistData?["tasklists"].rawString() {
            if let allTaskList = Mapper<TaskList>().mapArray(JSONString: tasklist) {
                XCTAssertNotNil(allTaskList)
                XCTAssertTrue(type(of: allTaskList[0]) == TaskList.self)
            } else {
                XCTFail()
            }
        }
    }
}
