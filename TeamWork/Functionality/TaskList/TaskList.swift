//
//  TaskList.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import ObjectMapper

/** Data mapping for tasklist */
struct TaskList {
    var uncompletedCount: Int?
    var complete: Bool?
    var id: String?
    var name: String?
    var description: String?
}

/** Implement Mappable for object mapping. */
extension TaskList : Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        uncompletedCount <- map["uncompleted-count"]
        complete <- map["complete"]
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
    }
}
