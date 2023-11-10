//
//  AuthViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet weak var authTitle: UILabel!
    @IBOutlet weak var authMessage: UILabel!
    @IBOutlet weak var profilePreview: CircleView!
    @IBOutlet weak var emailField: FieldView!
    @IBOutlet weak var passwordField: FieldView!
    @IBOutlet weak var nameField: FieldView!
    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var changeAuthType: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        changeAuthType.setTitle("You have an account ? Login", for: .normal)
        setField()
        loadButton()
    }
    
    @IBAction func changeAuth(_ sender: Any) {
        if changeAuthType.currentTitle == "You have an account ? Login"{
            changeAuthType.setTitle("Don't have an account ? Register", for: .normal)
            authTitle.text = "Hello, Pawrents !"
            authMessage.text = "Welcome Back"
            customButton.buttonLabel?.text = "Login"
            nameField.isHidden = true
            profilePreview.isHidden = true
        } else{
            changeAuthType.setTitle("You have an account ? Login", for: .normal)
            authTitle.text = "New User"
            authMessage.text = "Account Creation"
            customButton.buttonLabel?.text = "Create my account"
            nameField.isHidden = false
            profilePreview.isHidden = false
        }
    }
}

extension AuthViewController{
    func setField(){
        emailField.fieldName.text = "Email"
        passwordField.fieldName.text = "Password"
        nameField.fieldName.text = "Fullname"
    }
    
    func loadButton(){
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            self.customButton.buttonLabel?.font = customFont
        }
        customButton.tapAction = {
            let vc = TabBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Button tapped!")
        }
    }
}
