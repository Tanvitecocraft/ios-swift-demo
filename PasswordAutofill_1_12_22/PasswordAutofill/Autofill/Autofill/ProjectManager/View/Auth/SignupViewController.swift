//
//  SignupViewController.swift
//  Autofill
//
//  Created by Tecocraft
//

import UIKit

class SignupViewController: UIViewController {
    
    //MARK: - Declarations
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var infoTxtVw: UITextView!
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = appString.titleLogin
        SetupUI()
    }
    
    //MARK: - Functions
    /// This method is used for configure UI
    func SetupUI() {
        
        /// Set back button
        let btnBack = UIButton()
        btnBack.addTarget(self, action: #selector(btnBack_Clicked(_:)), for: .touchUpInside)
        
        let configBtn = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .small)
        let imgBack = UIImage.init(systemName: "chevron.backward", withConfiguration: configBtn )?.withRenderingMode(.alwaysTemplate)
        
        btnBack.setImage(imgBack, for: .normal)
        btnBack.tintColor = .appThemeColor
       
        let leftBarButtonItem = UIBarButtonItem(customView: btnBack)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        /// Set relevant sign in form elements
        txtUsername.textContentType = .username
        txtUsername.keyboardType = .emailAddress
        txtPassword.textContentType = .newPassword
        txtConfirmPassword.textContentType = .password
        
        infoTxtVw.isEditable = false
    }
    
    /// This method is used for Signing up into the App
    func SignUp() {
        /// hide keyboard
        self.view.endEditing(true)
        
        /// Validation for all fields
        if txtUsername.text?.isEmpty ?? true || txtPassword.text?.isEmpty ?? true || txtConfirmPassword.text?.isEmpty ?? true {
            showAlert(message: appString.mandatoryFieldsErr)
            return
        }
        
        /// Navigate to Home screen
        let nextVc = UIStoryboard.getViewController(with:UIStoryboard.Name.main.rawValue, vcIdentifier: HomeViewController.identifier) as! HomeViewController
        self.navigationController?.pushViewController(nextVc, animated:true)
    }
    
    //MARK: - Button Actions
    @IBAction func btnSignup_Clicked(_ sender: UIButton) {
        SignUp()
    }
    
    @IBAction func btnLogin_Clicked(_ sender: UIButton) {
        /// Navigate back  to Login screen
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack_Clicked(_ sender: UIButton) {
        /// Navigate back  to Login screen
        self.navigationController?.popViewController(animated: true)
    }
}
