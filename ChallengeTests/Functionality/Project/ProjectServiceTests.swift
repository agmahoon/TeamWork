//
//  ProjectServiceTests.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Challenge

class ProjectServiceTests: XCTestCase {
    
    typealias successBlock = (_ projects: Array<Project>) -> ()
    typealias failureBlock = (_ error: NSError) -> ()
    
    var successResponse = false
    var failureResponse = false
    var success: successBlock = {_ in }
    var failure: failureBlock = {_ in }
    
    override func setUp() {
        super.setUp()
        success = { (projects) in
            if projects.count == 0 {
                self.successResponse = false
                self.failureResponse = true
            } else {
                self.successResponse = true
                self.failureResponse = false
            }
        }
        
        failure = { (error) in
            self.failureResponse = true
            self.successResponse = false
        }
    }
    
    func testDataIsAllSetForProjectServiceRequest() {
        let subject = ProjectService(successBlock: success, failureBlock: failure)
        XCTAssertNotNil(subject)
        XCTAssertTrue(subject.path == RESTfulAPIPaths.projectPath)
        XCTAssertTrue(subject.method == .get)
        XCTAssertTrue(subject.header["Content-Type"] == "application/json")
        XCTAssertTrue(subject.requestData?.count == 0)
        XCTAssertTrue(subject.path.characters.count > 0)
    }
    
    func testSuccessHandlerForProjectServiceRequest() {
        let subject = ProjectService(successBlock: success, failureBlock: failure)
        XCTAssertNotNil(subject)
        XCTAssertTrue(subject.path == RESTfulAPIPaths.projectPath)
        XCTAssertTrue(subject.method == .get)
        XCTAssertTrue(subject.header["Content-Type"] == "application/json")
        XCTAssertTrue(subject.requestData?.count == 0)
        XCTAssertTrue(subject.path.characters.count > 0)
        XCTAssertFalse(successResponse)
        XCTAssertFalse(failureResponse)
        
        let url = NSURL(string: RESTfulAPIPaths.baseURL + subject.path)
        var statusCode = 200
        
        let parser = JSONParserHelper()
        let projectResponse = parser.parseJSON("projects")
        var response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: subject.header)
        subject.handleSuccessResponse(projectResponse, response: response)
        
        XCTAssertTrue(successResponse)
        XCTAssertFalse(failureResponse)
        
        response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: subject.header)
        subject.handleSuccessResponse(parser.parseJSON("tasklist"), response: response)
        
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        statusCode = 400
        response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: subject.header)
        subject.handleSuccessResponse(projectResponse, response: response)
        
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        subject.handleSuccessResponse(projectResponse, response: nil)
        
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
    }
    
    func testFailureHandlerForProjectServiceRequest() {
        let subject = ProjectService(successBlock: success, failureBlock: failure)
        XCTAssertNotNil(subject)
        XCTAssertTrue(subject.path == RESTfulAPIPaths.projectPath)
        XCTAssertTrue(subject.method == .get)
        XCTAssertTrue(subject.header["Content-Type"] == "application/json")
        XCTAssertTrue(subject.requestData?.count == 0)
        XCTAssertTrue(subject.path.characters.count > 0)
        XCTAssertFalse(successResponse)
        XCTAssertFalse(failureResponse)
        
        subject.handleError(nil, response: nil)
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
        
        let url = NSURL(string: RESTfulAPIPaths.baseURL + subject.path)
        let statusCode = 404
        let response = HTTPURLResponse(url: url! as URL, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: subject.header)
        
        let userInfo: [NSObject : AnyObject] = [
            NSLocalizedFailureReasonErrorKey as NSObject : NSLocalizedString("Error", value: "Unable to process your request", comment: "") as AnyObject
        ]
        let err = NSError(domain: Constants.domain, code: 1000, userInfo: userInfo)
        subject.handleError(err, response: response)
        
        XCTAssertFalse(successResponse)
        XCTAssertTrue(failureResponse)
    }
}
