//
//  Story.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import Foundation

struct Story: Codable {
    var section:String
    var title:String
    var abstract:String
    var url:URL
    var byline: String
    var createdDate: Date
    
    enum CodingKeys: String, CodingKey {
        case section
        case title
        case abstract
        case url
        case byline
        case createdDate = "created_date"
    }
}
