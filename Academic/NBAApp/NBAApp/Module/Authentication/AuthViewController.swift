//
//  AuthViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailBox: CustomTextField!
    @IBOutlet weak var passwordBox: CustomTextField!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var newAccountButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
        loadButton()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func loadButton(){
        newAccountButton.rx.tap
            .subscribe(onNext: {
                [weak self] in
                self?.buttonDidTap()
            })
            .disposed(by: disposeBag)
        
        customButton.tapAction = { [weak self] in
            // Post a notification with the data
            let data = true
            NotificationCenter.default.post(
                name: NSNotification.Name("DataNotification"),
                object: nil,
                userInfo: ["data": data]
            )
            self?.dismiss(animated: false)
            print("tapped!")
        }
    }
    
    func setUp(){
        checkBox.forgotButton.isHidden = true
        
        emailBox.textTypeImage.image = UIImage(systemName: "mail")
        emailBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        emailBox.authType.placeholder = "Email"
        passwordBox.textTypeImage.image = UIImage(systemName: "key.horizontal")
        passwordBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        passwordBox.authType.placeholder = "Password"
        passwordBox.eyeImage.image = UIImage(systemName: "eye")
        passwordBox.eyeImage.tintColor = UIColor(named: "TextColor")
    }
    
    func buttonDidTap(){
        if customButton.buttonLabel.text == "Sign in"{
            customButton.buttonLabel.text = "Sign up"
            checkBox.forgotButton.isHidden = false
            newAccountButton.titleLabel?.text = "Ready to dunk? Sign in"
        }else{
            customButton.buttonLabel.text = "Sign in"
            checkBox.forgotButton.isHidden = true
            newAccountButton.titleLabel?.text = "Don't have account? Sign up"
        }
    }
}
