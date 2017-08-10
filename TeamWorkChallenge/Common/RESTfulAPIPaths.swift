//
//  RESTfulAPIPaths.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation

/**
 Represent the base URL and paths for the RESTful APIs
 */
class RESTfulAPIPaths: NSObject {
    /**
     Base URL for the RESTful API
     */
    static var baseURL: String {
        get {
            return "https://yat.teamwork.com"
        }
    }
    
    /**
     Project path under RESTful API
     */
    static var projectPath: String {
        get {
            return "/projects.json"
        }
    }
    
    /**
     Tasklist path on a givent project
     */
    static var tasklistPath: String {
        get {
            return "/projects/{project_id}/tasklists.json"
        }
    }
    
    /**
     Task path on a givent task list
     */
    static var taskPathOnTaskList : String {
        get {
            return "/tasklists/{id}/tasks.json"
        }
    }
    
    /**
     Task path on a given project
     */
    static var taskPathOnProject : String {
        get {
            return "/projects/{id}/tasks.json"
        }
    }
    
    private override init() {
    }
}
