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
    
    func loadButton() {
        newAccountButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.buttonDidTap()
            })
            .disposed(by: disposeBag)
        
        customButton.tapAction = { [weak self] in
            guard let self = self else { return }
            
            let email = self.emailBox.authType.text ?? ""
            let password = self.passwordBox.authType.text ?? ""
            let rememberMe = self.checkBox.isRectangleFilled
            
            if self.customButton.buttonLabel.text == "Sign in" {
                if self.login(email: email, password: password) {
                    print("Login successful")
                    // Handle successful login
                    self.handleRememberMe(rememberMe: rememberMe, email: email)
                    let data = true
                    NotificationCenter.default.post(
                        name: NSNotification.Name("DataNotification"),
                        object: nil,
                        userInfo: ["data": data]
                    )
                    self.dismiss(animated: false)
                    print("tapped!")
                    print(email)
                } else {
                    print("Login failed")
                    // Handle failed login
                    self.showAuthFailed()
                }
            } else {
                self.register(email: email, password: password)
                print("User registered")
                // Handle registration
                self.handleRememberMe(rememberMe: rememberMe, email: email)
                let data = true
                NotificationCenter.default.post(
                    name: NSNotification.Name("DataNotification"),
                    object: nil,
                    userInfo: ["data": data]
                )
                self.dismiss(animated: false)
                print(email)
            }
        }
        
        passwordBox.tapAction = { [weak self] in
            guard let self = self else { return }
            
            // Store the current text
            let currentText = self.passwordBox.authType.text
            
            // Toggle the visibility of the password
            self.passwordBox.authType.isSecureTextEntry.toggle()
            
            // Check if the text has changed since the last tap
            if currentText != self.passwordBox.authType.text {
                // If the text has changed, set the stored text back
                self.passwordBox.authType.text = currentText
            }
            
            // Update the eye image to reflect the current state
            let eyeImageName = self.passwordBox.authType.isSecureTextEntry ? "eye.fill" : "eye.slash.fill"
            self.passwordBox.eyeImage.image = UIImage(systemName: eyeImageName)
        }
        
        // Set the initial state of the checkbox based on the stored preference
        checkBox.isRectangleFilled = UserDefaults.standard.bool(forKey: "RememberMe")
        
        // Check if "Remember Me" is true and an email is stored, then auto-fill the email field
        if checkBox.isRectangleFilled, let rememberedEmail = UserDefaults.standard.string(forKey: "RememberedEmail") {
            emailBox.authType.text = rememberedEmail
        }
        
        checkBox.forgetAction = { [weak self] in
            if let email = self?.emailBox.authType.text {
                self?.showForgotPasswordAlert(for: email)
            }
        }
    }
    
    
    func setUp(){
        checkBox.forgotButton.isHidden = false
        newAccountButton.setTitle("Don't have account? Sign up", for: .normal)
        emailBox.textTypeImage.image = UIImage(systemName: "mail")
        emailBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        emailBox.authType.placeholder = "Email"
        passwordBox.textTypeImage.image = UIImage(systemName: "key.horizontal")
        passwordBox.textTypeImage.tintColor = UIColor(named: "TextColor")
        passwordBox.authType.placeholder = "Password"
        passwordBox.eyeImage.image = UIImage(systemName: "eye.fill")
        passwordBox.eyeImage.tintColor = UIColor(named: "TextColor")
    }
    
    func buttonDidTap(){
        if customButton.buttonLabel.text == "Sign in"{
            customButton.buttonLabel.text = "Sign up"
            checkBox.forgotButton.isHidden = true
            newAccountButton.setTitle("Ready to dunk? Sign in", for: .normal)
        }else{
            customButton.buttonLabel.text = "Sign in"
            checkBox.forgotButton.isHidden = false
            newAccountButton.setTitle("Don't have account? Sign up", for: .normal)
        }
    }
    
    func login(email: String, password: String) -> Bool {
        if let savedUser = getUser(email: email), savedUser.password == password {
            // Successfully logged in
            UserDefaults.standard.set(email, forKey: "currentUserEmail")
            return true
        }
        return false
    }
    
    // Function to perform registration
    func register(email: String, password: String) {
        let newUser = User(email: email, password: password)
        saveUser(user: newUser)
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
    }
    
    // Function to get the current logged-in user
    func getCurrentUser() -> User? {
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
            return getUser(email: email)
        }
        return nil
    }
    
    // Function to save user to UserDefaults
    private func saveUser(user: User) {
        // In a real application, you would want to securely store user data.
        // For simplicity, we are using UserDefaults here.
        let userEncoded = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(userEncoded, forKey: user.email)
    }
    
    // Function to get user from UserDefaults
    private func getUser(email: String) -> User? {
        if let userData = UserDefaults.standard.data(forKey: email),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            return user
        }
        return nil
    }
    
    func handleRememberMe(rememberMe: Bool, email: String) {
        UserDefaults.standard.set(rememberMe, forKey: "RememberMe")
        
        // Optionally, you can save the email for future use
        if rememberMe {
            UserDefaults.standard.set(email, forKey: "RememberedEmail")
        } else {
            UserDefaults.standard.removeObject(forKey: "RememberedEmail")
        }
    }
    
    // Function to show a forgot password alert
    func showForgotPasswordAlert(for email: String) {
        let alertController = UIAlertController(title: "Forgot Password", message: "An email with your password has been sent to \(email).", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAuthFailed(){
        let alertController = UIAlertController(title: "Failed !", message: "Email or Password invalid.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
    
