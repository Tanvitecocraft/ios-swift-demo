//
//  HealthKitHelpar.swift
//  HealthKitDemo
//
//  Created by Tecocraft.
//

import Foundation
import HealthKit

typealias CompletionHandler = ((Bool, Error?) -> Void)

class HealthKitHelpar {
    
    static let share = HealthKitHelpar()
    
    let healthStore = HKHealthStore.init()
    
    /// this function is used for request healthkit data permission
    func requestAccessToHealthKit(completion: @escaping CompletionHandler) {
        
        guard   let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount),
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
                let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate),
                let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
                let basalEnergy = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)
        else { return }
        
        let readData:Set<HKObjectType> = [stepCountType, activeEnergy, heartRate, distanceType, basalEnergy]
        
        healthStore.requestAuthorization(toShare: nil, read: readData) { allow, error in
            if error != nil {
                completion(false,error)
            } else {
                completion(true,nil)
            }
        }
    }
    
    /// this function is used for get total step count
    func getstepCount(startDate: Date?,endDate: Date? = nil,completion:@escaping (Result<HKStepsModel,Error>)->Void) {
        
        let weightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let query = HKSampleQuery(sampleType: weightSampleType!, predicate: predicateForSamplesToday(startDate: startDate, endDate: endDate), limit: 0, sortDescriptors: nil, resultsHandler: {
            (query, results, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                var TotalSteps:Double = 0
                guard let data = results as? [HKQuantitySample] else { return }
                for steps in data
                {
                    TotalSteps += steps.quantity.doubleValue(for: HKUnit.count())
                }
                completion(.success(HKStepsModel(stepsCount: TotalSteps, Date: startDate?.currentUTCTimeZoneDate ?? "", endDate: endDate?.currentUTCTimeZoneDate ?? "")))
            }
        })
        self.healthStore.execute(query)
    }
    
    /// this function is used for get heart data
    func getHeartRate(startDate: Date?,endDate: Date? = nil,completion:@escaping (Result<HKHeartRateModel,Error>)->Void) {
        
        let weightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
        
        let query = HKSampleQuery(sampleType: weightSampleType!, predicate: predicateForSamplesToday(startDate: startDate, endDate: endDate), limit: 0, sortDescriptors: nil, resultsHandler: {
            (query, results, error) in
            if error != nil {
                completion(.failure(error!))
            } else {
                
                var arrHeartRate : [Double] = []
                
                for (_, sample) in results!.enumerated() {
                    guard let currData:HKQuantitySample = sample as? HKQuantitySample else { return }
                    arrHeartRate.append(currData.quantity.doubleValue(for: HKUnit(from: "count/min")))
                }
                
                let avg = (arrHeartRate.reduce(0, +)/Double(arrHeartRate.count))
                
                guard let Recentvalue = arrHeartRate.last,
                      let min = arrHeartRate.min(),
                      let max = arrHeartRate.max()
                else { return }
                
                print("Recent HeartRate   :- ", Recentvalue)
                print("Average HeartRate  :- ",avg)
                print("Minmum HeartRate :-",min)
                print("Maximum HeartRate :-",max)
                
                completion(.success(HKHeartRateModel(Recent: Recentvalue, avrage: avg, Maximum: max, Minmum: min, Date: Date().currentUTCTimeZoneDate)))
            }
        })
        
        self.healthStore.execute(query)
    }
    
    /// this function is used for get calorie unit data
    func getKilocalorieUnit(startDate: Date?,endDate: Date? = nil,completion: @escaping(Result<HKDistanceModel,Error>)->Void){
        
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let sampleQuery = HKSampleQuery(sampleType: heartRateType, predicate: self.predicateForSamplesToday(startDate: startDate, endDate: endDate), limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (_, results, error) in
            if error != nil{
                completion(.failure(error!))
            }else{
                
                var TotalCalorie:Double = 0
                guard let resultData = results else {
                    return
                }
                
                for quantity in resultData{
                    let qs = quantity as! HKQuantitySample
                    let q = qs.quantity
                    let unit = HKUnit.kilocalorie()
                    let uh = q.doubleValue(for: unit)
                    TotalCalorie += uh
                }
                
                completion(.success(HKDistanceModel(DistanceKM: TotalCalorie, Date: Date().currentUTCTimeZoneDate)))
            }
        }
        healthStore.execute(sampleQuery)
    }
    
    /// this function is used for get distance data
    func getDistance(startDate: Date?,endDate: Date? = nil,completion:@escaping (Result<HKDistanceModel,Error>)->Void) {
        
        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
        let timeSort = NSSortDescriptor.init(key: HKSampleSortIdentifierEndDate, ascending: false)
        let health = HKHealthStore.init()
        
        let query = HKSampleQuery.init(sampleType: distanceType!, predicate: self.predicateForSamplesToday(startDate: startDate, endDate: endDate), limit: HKObjectQueryNoLimit, sortDescriptors: [timeSort], resultsHandler: {(query,result,error)in
            if error != nil{
                completion(.failure(error!))
            }else{
                
                var TotalDistance:Double = 0
                guard let resultData = result else {
                    completion(.success(HKDistanceModel(DistanceKM: TotalDistance, Date: Date().currentUTCTimeZoneDate)))
                    return
                }
                
                for quantity in resultData{
                    let qs = quantity as! HKQuantitySample
                    let q = qs.quantity
                    let unit = HKUnit.meterUnit(with: .kilo)
                    let uh = q.doubleValue(for: unit)
                    TotalDistance += uh
                }
                completion(.success(HKDistanceModel(DistanceKM: TotalDistance, Date: startDate?.currentUTCTimeZoneDate ?? "")))
            }
            
        })
        health.execute(query)
    }
    
    /// this function is used for predicate get start date and end date
    func predicateForSamplesToday(startDate: Date? , endDate: Date? = nil) -> NSPredicate {
        
        let calendar = Calendar.current
        let componsssss :Set<Calendar.Component> = [Calendar.Component.day,Calendar.Component.month,Calendar.Component.year]
        var components = calendar.dateComponents(componsssss, from: startDate ?? Date())
        components.hour = 0
        components.minute = 0
        components.second = 0
        let startDate1 = calendar.date(from: components)
        print("start date", startDate ?? Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate1, end: endDate, options: .strictStartDate)
        return predicate
    }
    
}
