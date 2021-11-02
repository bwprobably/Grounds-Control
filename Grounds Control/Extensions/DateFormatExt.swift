//
//  DateFormatExt.swift
//  Grounds Control
//
//  Created by Brett on 10/13/21.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mm a"
            
        } else {
            formatter.dateFormat = "MM/dd/yy"
        }
        return formatter.string(from: self)
    }
}
