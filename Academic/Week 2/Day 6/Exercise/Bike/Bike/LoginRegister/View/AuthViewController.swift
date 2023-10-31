//
//  AuthViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: CustomEmailTextField!
    @IBOutlet weak var passwordField: CustomPasswordTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.placeholder = "Your Email"
        passwordField.placeholder = "Your Password"
    }
    
}
