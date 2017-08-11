//
//  ClientTests.swift
//  ChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Challenge

class ClientTests: XCTestCase {
    typealias completionBlockProject = (_ result: Array<Project>) -> ()
    typealias completionBlockTaskList = (_ result: Array<TaskList>) -> ()
    typealias failureBlock = (_ error: NSError?) -> ()
    
    var successResponse = false
    var failureResponse = false
    
    var successProject: completionBlockProject = {_ in }
    var successTaskList: completionBlockTaskList = {_ in }
    var failure: failureBlock = {_ in }
    
    override func setUp() {
        super.setUp()
        ClientAssembly.sharedAssembly.configureMocks()
        
        successProject = { (_) in
            self.successResponse = true
            self.failureResponse = false
        }
        successTaskList = { (_) in
            self.successResponse = true
            self.failureResponse = false
        }
        failure = { (_) in
            self.failureResponse = true
            self.successResponse = false
        }
    }
    
    override func tearDown() {
        super.tearDown()
        ClientAssembly.sharedAssembly.resetMocks()
        self.successResponse = false
        self.failureResponse = false
    }
    
    func testGetAllProjectsRequest() {
        let assembly = ClientAssembly.sharedAssembly
        XCTAssertNotNil(assembly)
        
        let request = ProjectService(successBlock: successProject, failureBlock: failure)
        XCTAssertNotNil(request)
        
        XCTAssertFalse(successResponse)
        XCTAssertFalse(failureResponse)
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        client.sendRequest.requestType = .project
        
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        client.sendRequest.resultType = .success
        client.enqueueRequest(request)
        XCTAssertTrue(successResponse)
        XCTAssertFalse(failureResponse)
        
        client.sendRequest.resultType = .failure
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
    }
    
    func testGetAllTaskListRequest() {
        let assembly = ClientAssembly.sharedAssembly
        let projectId = "54353"
        XCTAssertNotNil(assembly)
        
        let request = TaskListService(projectId: projectId, successBlock: successTaskList, failureBlock: failure)
        XCTAssertNotNil(request)
        
        XCTAssertFalse(successResponse)
        XCTAssertFalse(failureResponse)
        let client: ClientManagerMock = (assembly.getClientManager() as? ClientManagerMock)!
        client.sendRequest.requestType = .tasklist
        
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        client.sendRequest.resultType = .success
        client.enqueueRequest(request)
        XCTAssertTrue(successResponse)
        XCTAssertFalse(failureResponse)
        
        client.sendRequest.resultType = .failure
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        client.sendRequest.requestType = .none
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        client.sendRequest.resultType = .success
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        client.sendRequest.resultType = .failure
        client.enqueueRequest(request)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
    }
    
}
