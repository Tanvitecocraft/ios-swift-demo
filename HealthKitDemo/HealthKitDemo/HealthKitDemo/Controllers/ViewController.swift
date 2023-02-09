//
//  ViewController.swift
//  HealthKitDemo
//
//  Created by Tecocraft on 25/08/21.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    //MARK: - Declarations
    
    @IBOutlet weak var vwDatePicker: UIView!
    @IBOutlet weak var vwSteps: UIView!
    @IBOutlet weak var vwHeartRate: UIView!
    @IBOutlet weak var vwDisatnce: UIView!
    @IBOutlet weak var vwCaloriUnit: UIView!
    @IBOutlet weak var vwDatePickerAndToolbar: UIView!
    
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var lblStepCount: UILabel!
    @IBOutlet weak var lblTxtStep: UILabel!
    
    @IBOutlet weak var lblHeartRate: UILabel!
    @IBOutlet weak var lblHeartRateValue: UILabel!
    @IBOutlet weak var lblTxtHeart: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDistanceValue: UILabel!
    @IBOutlet weak var lblTxtDisatnce: UILabel!
    
    @IBOutlet weak var lblCaloriUnit: UILabel!
    @IBOutlet weak var lblCaloriUnitValue: UILabel!
    @IBOutlet weak var lbltxtCaloriUnit: UILabel!
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    
    @IBOutlet weak var btnStepStartDate: UIButton!
    @IBOutlet weak var btnSetpEndDate: UIButton!
    
    @IBOutlet weak var btnHeartrateStartDate: UIButton!
    @IBOutlet weak var btnHeartrateEndDate: UIButton!
    
    @IBOutlet weak var btnDisatnceStartDate: UIButton!
    @IBOutlet weak var btnDistanceEndDate: UIButton!
    
    @IBOutlet weak var btnCaloriunitStartDate: UIButton!
    @IBOutlet weak var btnCaloriunitEndDate: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    //MARK: - Private var
    
    private var stepStartDate: Date? = nil
    private var stepEndDate: Date = Date()
    
    private var ditanceStartDate: Date? = nil
    private var distanceEndDate: Date = Date()
    
    private var heartStartDate: Date? = nil
    private var heartEndDate: Date = Date()
    
    private var calorieStartDate: Date? = nil
    private var calorieEndDate: Date = Date()
    
    private var tag: SelctedBtn = .startStepDate
    
    //MARK: - View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - Helper methods
    
    
    /// this function is used for configuration UI
    private func setupUI() {
        
        HealthKitHelpar.share.requestAccessToHealthKit { allow, error in
        }
        
        vwDatePickerAndToolbar.isHidden = true
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        self.toolBar.barTintColor = UIColor.white
        
        [vwSteps,vwDisatnce,vwHeartRate,vwCaloriUnit].forEach {
            $0?.layer.cornerRadius = 12
            $0?.backgroundColor =  UIColor.gray.withAlphaComponent(0.2)
        }
        
        [self.lblStepCount,self.lblHeartRateValue,self.lblDistanceValue,self.lblCaloriUnitValue].forEach {
            $0?.font = UIFont.systemFont(ofSize: 30.0)
        }
        
        [self.lblTxtStep,self.lblTxtHeart,self.lbltxtCaloriUnit,self.lblTxtDisatnce].forEach {
            $0?.font = UIFont.systemFont(ofSize: 16.0)
            $0?.textColor = .gray
        }
        
        [self.lblSteps,self.lblDistance,self.lblHeartRate,self.lblCaloriUnit].forEach {
            $0?.textColor = .orange
        }
        
        [self.lblStepCount,self.lblDistanceValue,self.lblHeartRateValue,self.lblCaloriUnitValue].forEach {
            $0.text = Str.zero
        }
        
        self.lblSteps.text = Str.steps
        self.lblHeartRate.text = Str.heartRate
        self.lblCaloriUnit.text = Str.calorieUnit
        self.lblDistance.text = Str.distance
        
        self.lblTxtStep.text = Str.steps.lowercased()
        self.lblTxtHeart.text = Str.bPM
        self.lblTxtDisatnce.text = Str.km
        self.lbltxtCaloriUnit.text = Str.cal
        
        self.btnStepStartDate.tag = SelctedBtn.startStepDate.rawValue
        self.btnSetpEndDate.tag = SelctedBtn.endStepDate.rawValue
        
        self.btnDisatnceStartDate.tag = SelctedBtn.startDistanceDate.rawValue
        self.btnDistanceEndDate.tag = SelctedBtn.endDistanceDate.rawValue
        
        self.btnHeartrateStartDate.tag = SelctedBtn.startHeartrateDate.rawValue
        self.btnHeartrateEndDate.tag = SelctedBtn.endHeartDate.rawValue
        
        self.btnCaloriunitStartDate.tag = SelctedBtn.startCaloriunitDate.rawValue
        self.btnCaloriunitEndDate.tag = SelctedBtn.endCaloriUnitDate.rawValue
    }
    
    /// this function is use for get step data
    private func getStepData() {
        
        HealthKitHelpar.share.getstepCount(startDate: self.stepStartDate, endDate: self.stepEndDate) { response in
            switch response {
            case .success(let stepCount):
                DispatchQueue.main.async {
                    self.lblStepCount.text = "\(stepCount.stepsCount)"
                    print("stepCount => \(stepCount)")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    /// this function is use for get distance data
    private func getDistanceData() {
        
        HealthKitHelpar.share.getDistance(startDate: self.ditanceStartDate, endDate: self.distanceEndDate) { response in
            switch response {
            case .success(let distanceData):
                DispatchQueue.main.async {
                    self.lblDistanceValue.text = "\(Double(round(100 * distanceData.DistanceKM) / 100))"
                }
                print("distanceData => \(distanceData)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    /// this function is use for get health rate data
    private func getHealthRateData() {
        
        HealthKitHelpar.share.getHeartRate(startDate: self.heartStartDate, endDate: self.heartEndDate) { response in
            switch response {
            case .success(let heartRateData):
                DispatchQueue.main.async {
                    self.lblHeartRateValue.text = "\(Double(round(100 * heartRateData.avrage) / 100))"
                    print("heartRateData => \(heartRateData)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// this function is use for get  caloriunit data
    private func getCalorieUnitData() {
        
        HealthKitHelpar.share.getKilocalorieUnit(startDate: self.calorieStartDate, endDate: self.calorieEndDate) { response in
            switch response {
            case .success(let calorieUnit):
                DispatchQueue.main.async {
                    self.lblCaloriUnitValue.text = "\(Double(round(100 * calorieUnit.DistanceKM) / 100))"
                }
                print("calorieUnit => \(calorieUnit)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    /// this function is use for compare start date and end date
    private func isValid(startDate : Date, endDate: Date) -> Bool {
        var isValid = true
        
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        let  validDate = days.day
        
        validDate ?? 0 >= 0 ? (isValid = true) : (isValid = false)
        
        return isValid
    }
    
    /// this function is use for showing alert
    func openAlert(Message: String, vc: UIViewController) {
        let alert = UIAlertController(title: "", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Str.ok, style:   UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// this function is used for get seprate health data
    private func getHealthData() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Str.ddMMyyyy
        
        switch tag {
            
        case .startStepDate:
            stepStartDate = datePicker.date
            
            if isValid(startDate: stepStartDate ?? Date(), endDate: stepEndDate) {
                btnStepStartDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getStepData()
            } else {
                openAlert(Message: Str.errStartDate, vc: self)
            }
        case .endStepDate:
            stepEndDate = datePicker.date
            
            if let stepStartDate = stepStartDate {
                
                if isValid(startDate: stepStartDate, endDate: stepEndDate) {
                    btnSetpEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                    getStepData()
                } else {
                    openAlert(Message: Str.errEndDate, vc: self)
                }
            } else {
                stepStartDate = Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1))
                btnSetpEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getStepData()
            }
            
        case .startHeartrateDate:
            heartStartDate = datePicker.date
            
            if isValid(startDate: heartStartDate ?? Date(), endDate: heartEndDate) {
                btnHeartrateStartDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getHealthRateData()
            } else {
                openAlert(Message: Str.errStartDate, vc: self)
            }
        case .endHeartDate:
            heartEndDate = datePicker.date
            
            if let heartStartDate = heartStartDate {
                
                if isValid(startDate: heartStartDate, endDate: heartEndDate) {
                    btnHeartrateEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                    getHealthRateData()
                } else {
                    openAlert(Message: Str.errEndDate, vc: self)
                }
            } else {
                heartStartDate = Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1))
                btnHeartrateEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getHealthRateData()
            }
            
        case .startDistanceDate:
            ditanceStartDate = datePicker.date
            
            if isValid(startDate: ditanceStartDate ?? Date(), endDate: distanceEndDate) {
                btnDisatnceStartDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getDistanceData()
            } else {
                openAlert(Message: Str.errStartDate, vc: self)
            }
        case .endDistanceDate:
            distanceEndDate = datePicker.date
            
            if let ditanceStartDate = ditanceStartDate {
                
                if isValid(startDate: ditanceStartDate, endDate: distanceEndDate) {
                    btnDistanceEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                    getDistanceData()
                } else {
                    openAlert(Message: Str.errEndDate, vc: self)
                }
            } else {
                ditanceStartDate = Calendar.current.date(from: DateComponents(year: 1, month: 1, day: 1))
                btnDistanceEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getDistanceData()
            }
            
        case .startCaloriunitDate:
            calorieStartDate = datePicker.date
            
            if isValid(startDate: calorieStartDate ?? Date(), endDate: calorieEndDate) {
                btnCaloriunitStartDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getCalorieUnitData()
            } else {
                openAlert(Message: Str.errStartDate, vc: self)
            }
        case .endCaloriUnitDate:
            calorieEndDate = datePicker.date
            
            if let calorieStartDate = calorieStartDate {
                if isValid(startDate: calorieStartDate, endDate: calorieEndDate) {
                    btnCaloriunitEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                    getCalorieUnitData()
                } else {
                    openAlert(Message: Str.errEndDate, vc: self)
                }
            } else {
                calorieStartDate = Calendar.current.date(from: DateComponents(year: 0, month: 0, day: 0))
                btnCaloriunitEndDate.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
                getCalorieUnitData()
            }
        }
        
    }
    
    //MARK: - Button Actions
    
    @IBAction func clickOnBtnStart(_ sender: UIButton) {
        vwDatePickerAndToolbar.isHidden = false
        tag = SelctedBtn.init(rawValue: sender.tag) ?? .startStepDate
    }
    
    @IBAction func clickOnBtnEnd(_ sender: UIButton) {
        vwDatePickerAndToolbar.isHidden = false
        tag = SelctedBtn.init(rawValue: sender.tag) ?? .endStepDate
    }
    
    @IBAction func clickOnBtnCancel(_ sender: UIButton) {
        vwDatePickerAndToolbar.isHidden = true
    }
    
    @IBAction func clickOnBtnDone(_ sender: UIButton) {
        vwDatePickerAndToolbar.isHidden = true
        self.getHealthData()
    }
    
}
