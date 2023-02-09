//
//  HomeViewController.swift
//  Autofill
//
//  Created by Tecocraft on 21/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - Declarations
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = appString.titleHome
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - Button Actions
    @IBAction func btnLogout_Clicked(_ sender: UIButton) {
        /// Navigate back  to Login screen
        self.navigationController?.popToRootViewController(animated: true)
    }
}
