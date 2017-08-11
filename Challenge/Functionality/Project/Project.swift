//
//  Project.swift
//  Challenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import ObjectMapper

/** Data mapping for project ( I've added few fields for project due to limited time.) */
struct Project {
    var logo: String?
    var status: String?
    var startDate: String?
    var id: String?
    var endDate: String?
    var name: String?
    var description: String?
}

/** Implement Mappable for object mapping. */
extension Project : Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        logo <- map["logo"]
        status <- map["status"]
        startDate <- map["startDate"]
        id <- map["id"]
        endDate <- map["endDate"]
        name <- map["name"]
        description <- map["description"]
    }
}
