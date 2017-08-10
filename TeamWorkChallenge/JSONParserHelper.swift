//
//  JSONParserHelper.swift
//  TeamWorkChallengeTests
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation
import SwiftyJSON

/** An interface that parse the json string file into JSON object. */
class JSONParserHelper: NSObject {
    
    /**
     Parse the given JSON file.
     - parameter filename: The name of the json file that contain json string.
     - return JSON: Return JSON object after parsing string json file.
     */
    func parseJSON(_ filename: String) -> JSON? {
        guard let url = URL(string: "\(filename).json") else {
            return nil
        }
        
        guard let filePath = Bundle.main.path(
            forResource: url.deletingPathExtension().absoluteString,
            ofType: url.pathExtension
            ) else {
                return nil
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath, isDirectory: false))

        return JSON(data: data)
    }
}
