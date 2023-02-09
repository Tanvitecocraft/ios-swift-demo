//
//  ThemeTextfield.swift


import UIKit
import Foundation

class ThemeTextfield: UITextField, UITextFieldDelegate {
    
    private var currentVC: UIViewController?
    private var nextField : ThemeTextfield?
    var password : String?
    
    public var isPasswordField = Bool()
    private var fieldIconName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        
        delegate = self
        font = UIFont.systemFont(ofSize: 16)
        layer.cornerRadius = self.bounds.height / 2
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        tintColor = .appThemeColor
        textColor = .fontBlackColor
        clipsToBounds = true
        borderStyle = .none
        autocorrectionType = .no
        
        setupLeftPadding()
    }
    
    func setupLeftPadding() {
        leftViewMode = UITextField.ViewMode.always
        leftViewMode = .always
        
        let iconHeight = bounds.height / 3
        let iconXpoint: CGFloat = 0
        
        let leftimageView = UIView(frame: CGRect(x: 0, y: 0, width: iconHeight + iconXpoint + 8, height: bounds.height))
        
        leftView = leftimageView
    }
   
    //MARK: - UITextField Delegate
    /// <#Description#>
    /// - Parameter textField: <#textField description#>
    /// - Returns: <#description#>
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return false
    }
}

