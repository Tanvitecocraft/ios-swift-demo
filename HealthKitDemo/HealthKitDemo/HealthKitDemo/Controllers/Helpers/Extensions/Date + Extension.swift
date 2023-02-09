//
//  Date + Extension.swift
//  HealthKitDemo
//
//  Created by Tecocraft 
//

import Foundation

extension Date {
    var currentUTCTimeZoneDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: self)
    }
}
