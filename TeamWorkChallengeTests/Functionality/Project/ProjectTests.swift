//
//  ProjectTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import TeamWorkChallenge

class ProjectTests: XCTestCase {
    
    func testPropertiesAreSetForProject() {
        let project = Project(
            logo: "some-url",
            status: "active",
            startDate: "20121212",
            id: "898393",
            endDate: "20121212",
            name: "name",
            description: "description"
        )
        var project2 = project
        XCTAssertEqual(project.description, project2.description)
        
        project2.description = "New Description"
        XCTAssertNotEqual(project.description, project2.description)
    }
    
    func testProjectProperiesAreMappleWithJSON() {
        let parser = JSONParserHelper()
        let projectData = parser.parseJSON("projects")
        
        if let projects = projectData?["projects"].rawString() {
            if let allProjects = Mapper<Project>().mapArray(JSONString: projects) {
                XCTAssertNotNil(allProjects)
                XCTAssertTrue(type(of: allProjects[0]) == Project.self)
            } else {
                XCTFail()
            }
        }
    }
}
