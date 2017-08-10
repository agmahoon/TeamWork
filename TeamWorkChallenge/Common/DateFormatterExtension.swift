//
//  DateFormatterExtension.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import Foundation

/** An extension to facilitate desire format for given string date. */
extension String {
    func convertDateFormater() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyymmdd"
        let date = dateFormatter.date(from: self)
        if let date = date {
            dateFormatter.dateFormat = "yyyy-mm-dd"
            return  dateFormatter.string(from: date)
        }
        return ""
    }
}
