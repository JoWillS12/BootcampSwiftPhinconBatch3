//
//  AuthViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class AuthViewController: UIViewController, AuthSliderDelegate {
    
    @IBOutlet weak var authenticSlider: AuthSlider!
    @IBOutlet weak var emailField: InputField!
    @IBOutlet weak var passwordField: InputField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        emailField.labelType.text = "Email"
        passwordField.labelType.text = "Password"
        authenticSlider.delegate = self
    }
}
extension AuthViewController{
    
    func thumbReachedDestination() {
        let vc = TabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func thumbCurrentPosition(_ position: CGFloat) {
    }
    
}
