//
//  AuthViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//
import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var authTitle: UILabel!
    @IBOutlet weak var authMessage: UILabel!
    @IBOutlet weak var profilePreview: CircleView!
    @IBOutlet weak var emailField: FieldView!
    @IBOutlet weak var passwordField: FieldView!
    @IBOutlet weak var nameField: FieldView!
    @IBOutlet weak var customButton: CustomButton!
    @IBOutlet weak var changeAuthType: UIButton!
    
    // MARK: - ViewModel
    
    var viewModel = AuthViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        changeAuthType.setTitle("You have an account ? Login", for: .normal)
        setField()
        loadButton()
    }
    
    // MARK: - Actions
    
    @IBAction func changeAuth(_ sender: Any) {
        toggleAuthType()
    }
}

// MARK: - Private Extension

private extension AuthViewController {
    
    // MARK: - Configuration
    
    func setField() {
        emailField.fieldName.text = "Email"
        passwordField.fieldName.text = "Password"
        nameField.fieldName.text = "Fullname"
    }
    
    func loadButton() {
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            self.customButton.buttonLabel?.font = customFont
        }
        customButton.tapAction = { [weak self] in
            self?.handleButtonTap()
        }
    }
    
    // MARK: - Authentication Handling
    
    func toggleAuthType() {
        if changeAuthType.currentTitle == "You have an account ? Login" {
            configureForLogin()
        } else {
            configureForRegistration()
        }
    }
    
    func configureForLogin() {
        changeAuthType.setTitle("Don't have an account ? Register", for: .normal)
        authTitle.text = "Hello, Pawrents !"
        authMessage.text = "Welcome Back"
        customButton.buttonLabel?.text = "Login"
        nameField.isHidden = true
        profilePreview.isHidden = true
    }
    
    func configureForRegistration() {
        changeAuthType.setTitle("You have an account ? Login", for: .normal)
        authTitle.text = "New User"
        authMessage.text = "Account Creation"
        customButton.buttonLabel?.text = "Create my account"
        nameField.isHidden = false
        profilePreview.isHidden = false
    }
    
    // MARK: - Button Handling
    
    func handleButtonTap() {
        if changeAuthType.currentTitle == "You have an account ? Login" {
            registerUser()
        } else {
            loginUser()
        }
    }
    
    // MARK: - Authentication Requests
    
    private func loginUser() {
        guard let email = emailField.inputType.text, let password = passwordField.inputType.text else { return }
        let param = LoginParam(email: email, password: password)
        
        viewModel.loginUser(param: param) { [weak self] data in
            print("Token : \(data.token)")
            self?.navigateToTab()
        }
    }
    
    private func registerUser() {
        guard let email = emailField.inputType.text,
              let password = passwordField.inputType.text,
              let name = nameField.inputType.text,
              let imageBase64 = profilePreview.getBase64StringFromImage() else { return }
        let param = RegisterParam(name: name, email: email, password: password, image: imageBase64)
        
        viewModel.registerUser(param: param) { [weak self] data in
            print(data)
            self?.navigateToTab()
        }
    }
    
    // MARK: - Navigation
    
    func navigateToTab() {
        let vc = TabBarViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }
}
