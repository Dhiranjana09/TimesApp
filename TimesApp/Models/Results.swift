//
//  Results.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import Foundation

struct Results: Codable {
    var copyright: String
    var lastUpdated: Date
    var results :[Story]
    
    enum CodingKeys: String, CodingKey {
            case copyright
            case results
            case lastUpdated = "last_updated"
        }
}
