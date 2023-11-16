//
//  AuthViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailBox: CustomTextField!
    @IBOutlet weak var passwordBox: CustomTextField!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var newAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp(){
        emailBox.textTypeImage.image = UIImage(systemName: "mail")
        emailBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        emailBox.authType.text = "Email"
        passwordBox.textTypeImage.image = UIImage(systemName: "key.horizontal")
        passwordBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        passwordBox.authType.text = "Password"
        passwordBox.eyeImage.image = UIImage(systemName: "eye")
        passwordBox.eyeImage.tintColor = UIColor(named: "TextColor")
    }
}
