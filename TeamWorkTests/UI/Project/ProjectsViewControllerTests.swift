//
//  ProjectsViewControllerTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 10/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
@testable import TeamWork

class ProjectsViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        ClientAssembly.sharedAssembly.configureMocks()
    }
    
    func testViewDidLoad() {
        let assembly = ClientAssembly.sharedAssembly
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        XCTAssertTrue(type(of: client) == ClientManagerMock.self)
        
        let subject = ProjectsViewController()
        XCTAssertNotNil(subject)
        XCTAssertNil(subject.tableView)
        
        subject.makeRootAndLoadView()
        XCTAssertNotNil(subject)
        
        XCTAssertNotNil(subject.tableView)
        XCTAssertEqual(subject.title, "PROJECTS")
        XCTAssertTrue(subject.navigationItem.rightBarButtonItems?.count == 1)
    }
    
    func testDataSourceInTableViewIsCorrectForProject() {
        let assembly = ClientAssembly.sharedAssembly
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        XCTAssertTrue(type(of: client) == ClientManagerMock.self)
        client.sendRequest.requestType = .project
        client.sendRequest.resultType = .success
        
        let subject = ProjectsViewController()
        XCTAssertNotNil(subject)
        XCTAssertNil(subject.tableView)
        
        subject.makeRootAndLoadView()
        XCTAssertNotNil(subject)
        let parser = JSONParserHelper()
        let projectResponse = parser.parseJSON("projects")
        
        let numberOfRows = subject.tableView.numberOfRows(inSection: 0)
        XCTAssertTrue(numberOfRows == projectResponse?["projects"].count)
        
        let numberSections = subject.tableView.numberOfSections
        XCTAssertTrue(numberSections == 1)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = subject.tableView.cellForRow(at: indexPath) as? ProjectTableViewCell
        XCTAssertTrue(cell?.name.text == projectResponse?["projects"][0]["name"].stringValue) // can be tested more fields.
    }
}

extension UIViewController {
    func makeRootAndLoadView() {
        UIApplication.shared.keyWindow?.rootViewController = self
        let _ = self.view
        
    }
}
