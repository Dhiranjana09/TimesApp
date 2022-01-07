//
//  Extensions.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 25/11/21.
//

import Foundation

extension String {
    func dateFormater(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateStr = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateStr)
    }
}
