//
//  UIViewController+Extension.swift
//  Firm Pet
//
//  Created by Tecocraft on 28/06/22.
//

import UIKit

extension UIViewController {
    
    //MARK: - Get Viewcontroller identifier name
    class var identifier: String {
        return NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    //MARK: - Show/Hide Alerts
    /**
    This methos is used to show AlertView.
    */
    func showAlert(with title: String = "", message: String, handler: ((UIAlertAction) -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: appString.alertOk, style: .default, handler:handler))
        present(alert, animated: true)
    }
}
