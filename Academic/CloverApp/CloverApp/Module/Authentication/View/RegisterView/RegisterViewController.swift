//
//  RegisterViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var regisButton: ButtonView!
    @IBOutlet weak var repasswordBox: FieldView!
    @IBOutlet weak var passwordBox: FieldView!
    @IBOutlet weak var phoneBox: FieldView!
    @IBOutlet weak var emailBox: FieldView!
    @IBOutlet weak var backView: UIView!
    
    var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        setUp()
        loadButton()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func setUp(){
        backView.applyCommonBackgroundStyle()
        
        emailBox.configure(withFieldName: "Email", placeholder: "Enter your email")
        phoneBox.configure(withFieldName: "Phone-NO", placeholder: "Enter your phone number")
        passwordBox.configure(withFieldName: "Password", placeholder: "Enter your password")
        repasswordBox.configure(withFieldName: "Confirm Password", placeholder: "Re-enter your password")
        
        regisButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        regisButton.buttonLabel.text = "Sign in"
    }
    
    func loadButton(){
        regisButton.tapAction = {[weak self] in
            guard let email = self?.emailBox.inputType.text,
                  let password = self?.passwordBox.inputType.text,
                  let phoneNum = self?.phoneBox.inputType.text,
                  let confirmPassword = self?.repasswordBox.inputType.text else {
                self?.showAlert(message: "Please fill in all the fields.")
                return
            }
            
            self?.viewModel.registerUser(email: email, password: password, confirmPassword: confirmPassword, phoneNum: phoneNum) { result in
                switch result {
                case .success:
                    // Registration successful
                    print("Registration successful")
                    
                    // Example: Check registration status and navigate to the next screen
                    if ((self?.viewModel.isUserRegistered()) != nil) {
                        self?.navigationController?.setViewControllers([FillViewController()], animated: false)
                    } else {
                        // Handle as needed
                    }
                    
                case .failure(let error):
                    // Show an alert indicating registration failure
                    self?.showAlert(message: "Registration failed. Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
