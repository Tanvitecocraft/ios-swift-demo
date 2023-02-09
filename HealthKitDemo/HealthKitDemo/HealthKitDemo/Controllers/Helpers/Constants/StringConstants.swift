//
//  StringConstants.swift
//  HealthKitDemo
//
//  Created by Tecocraft on 23/11/22.
//

import Foundation

/// this enum is used for string constant
enum Str {
    static let steps            = "Steps"
    static let heartRate        = "HeartRate"
    static let calorieUnit      = "CalorieUnit"
    static let distance         = "Distance"
    
    static let bPM              = "BPM"
    static let km               = "km"
    static let cal              = "cal"
    
    static let zero             = "0.0"
    
    static let ok               = "OK"
    
    static let ddMMyyyy         = "dd-MM-yyyy"
    
    static let errStartDate     = "start date is not bigger than end date"
    static let errEndDate       = "end date is not smaller than start date"
}

/// this enum is used for start date and end date for perticular health data
enum SelctedBtn:Int {
    case startStepDate
    case endStepDate
    case startDistanceDate
    case endDistanceDate
    case startHeartrateDate
    case endHeartDate
    case startCaloriunitDate
    case endCaloriUnitDate
}
