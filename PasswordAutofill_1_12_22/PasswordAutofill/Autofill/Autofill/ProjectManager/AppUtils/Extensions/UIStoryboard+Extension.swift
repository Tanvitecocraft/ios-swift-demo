//
//  UIStoryboard+Extension.swift
//  Firm Pet
//
//  Created by Tecocraft on 29/06/22.
//

import UIKit

extension UIStoryboard {
    
    ///enum for get storyboard name
    enum Name: String {
        case main       = "Main"
    }
    
    /// This method is used for get viewController from its identifier.
    /// - Parameter storyboardName: Name of storyboard.
    ///             vcIdentifier:  UIViewController storyboard identifier.
    /// - Returns: UIViewController object.
    class func getViewController(with storyboardName:String, vcIdentifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        return sb.instantiateViewController(withIdentifier: vcIdentifier)
    }
    
    /// This method is used for get viewController from its identifier.
    /// - Parameter storyboardName: Name of storyboard.
    ///             navIdentifier:  UINavigationController  storyboard identifier.
    /// - Returns: UINavigationController object.
    class func getNavigationController(with storyboardName:String, navIdentifier: String) -> UINavigationController? {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        return sb.instantiateViewController(withIdentifier: navIdentifier) as? UINavigationController
    }
    
    /// This method is used for get storyboard from its name.
    /// - Parameter name: Name of storyboard.
    /// - Returns: UIStoruboard object.
    class func getStoryboard(for name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
}
