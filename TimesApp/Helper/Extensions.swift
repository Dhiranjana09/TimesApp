//
//  Extensions.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 25/11/21.
//

import Foundation

extension Date {
    var relativeDateTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
