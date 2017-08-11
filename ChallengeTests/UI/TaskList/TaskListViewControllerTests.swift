//
//  TaskListViewControllerTests.swift
//  ChallengeTests
//
//  Created by Abdul Ghafoor on 10/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest

@testable import Challenge

class TaskListViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        ClientAssembly.sharedAssembly.configureMocks()
    }
    
    func testViewDidLoad() {
        let assembly = ClientAssembly.sharedAssembly
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        XCTAssertTrue(type(of: client) == ClientManagerMock.self)
        
        let subject = TaskListViewController()
        XCTAssertNotNil(subject)
        XCTAssertNil(subject.tableView)
        
        subject.makeRootAndLoadView()
        XCTAssertNotNil(subject)
        
        XCTAssertNotNil(subject.tableView)
        XCTAssertEqual(subject.title, "TASK LIST")
        XCTAssertTrue(subject.navigationItem.rightBarButtonItems?.count == 2)
    }
    
    func testDataSourceInTableViewIsCorrectForTaskList() {
        let assembly = ClientAssembly.sharedAssembly
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        XCTAssertTrue(type(of: client) == ClientManagerMock.self)
        client.sendRequest.requestType = .tasklist
        client.sendRequest.resultType = .success
        
        let subject = TaskListViewController()
        subject.projectId = "23498" //dummy value
        XCTAssertNotNil(subject)
        
        subject.makeRootAndLoadView()
        XCTAssertNotNil(subject)
        
        let parser = JSONParserHelper()
        let taskListData = parser.parseJSON("tasklist")
        
        let numberOfRows = subject.tableView.numberOfRows(inSection: 0)
        XCTAssertTrue(numberOfRows == taskListData?["tasklists"].count)
        
        let numberSections = subject.tableView.numberOfSections
        XCTAssertTrue(numberSections == 1)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = subject.tableView.cellForRow(at: indexPath)
        XCTAssertTrue(cell?.textLabel?.text == taskListData?["tasklists"][0]["name"].stringValue)
    }
    
    func testDataSourceInTableViewIsCorrectForTaskListWhenFailed() {
        let assembly = ClientAssembly.sharedAssembly
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        XCTAssertTrue(type(of: client) == ClientManagerMock.self)
        client.sendRequest.requestType = .tasklist
        client.sendRequest.resultType = .success
        
        let subject = TaskListViewController()
        subject.projectId = "23498" //dummy value
        XCTAssertNotNil(subject)
        subject.makeRootAndLoadView()
        
        client.sendRequest.resultType = .failure
        subject.projectId = "23238" //dummy value
        if type(of: subject.presentedViewController!) == UIAlertController.self {
            let numberOfRows = subject.tableView.numberOfRows(inSection: 0)
            XCTAssertTrue(numberOfRows == 0)
            
            let numberSections = subject.tableView.numberOfSections
            XCTAssertTrue(numberSections == 1)
        } else {
            XCTFail()
        }
    }
}
