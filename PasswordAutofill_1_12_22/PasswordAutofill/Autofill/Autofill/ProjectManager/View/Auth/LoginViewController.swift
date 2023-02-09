//
//  LoginViewController.swift
//  Autofill
//
//  Created by Tecocraft
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Declarations
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = appString.titleLogin
        SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// Reset fields
        txtUsername.text = ""
        txtPassword.text = ""
    }
    
    //MARK: - Functions
    /// This method is used for configure UI
    func SetupUI() {
        
        /// Set relevant sign in form elements
        txtUsername.textContentType = .username
        txtUsername.keyboardType = .emailAddress
        txtPassword.textContentType = .password
    }
    
    /// This method is used for Login into the App
    func Login() {
        /// hide keyboard
        self.view.endEditing(true)
        
        /// Validation for all fields
        if txtUsername.text?.isEmpty ?? true || txtPassword.text?.isEmpty ?? true {
            showAlert(message: appString.mandatoryFieldsErr)
            return
        }
        
        /// Navigate to Home screen
        let nextVc = UIStoryboard.getViewController(with:UIStoryboard.Name.main.rawValue, vcIdentifier: HomeViewController.identifier) as! HomeViewController
        self.navigationController?.pushViewController(nextVc, animated:true)
    }
    
    @IBAction func btnLogin_Clicked(_ sender: UIButton) {
        Login()
    }
    
    /// This method is used for Signup into the App
    @IBAction func btnSignUp_Clicked(_ sender: UIButton) {
        
        /// Navigate to Signup screen
        let nextVc = UIStoryboard.getViewController(with:UIStoryboard.Name.main.rawValue, vcIdentifier: SignupViewController.identifier) as! SignupViewController
        self.navigationController?.pushViewController(nextVc, animated:true)
    }
}
