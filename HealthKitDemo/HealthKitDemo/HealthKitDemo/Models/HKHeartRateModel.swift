//
//  HKHeartRateModel.swift
//  HealthKitDemo
//
//  Created by Tecocraft on 24/11/22.
//

import Foundation

struct HKHeartRateModel:Codable {
    let Recent:Double
    let avrage:Double
    let Maximum:Double
    let Minmum:Double
    let Date:String
}
