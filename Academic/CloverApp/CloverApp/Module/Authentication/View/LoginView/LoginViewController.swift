//
//  LoginViewController.swift
//  CloverApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleButton: GIDSignInButton!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var loginButton: ButtonView!
    @IBOutlet weak var passwordBox: FieldView!
    @IBOutlet weak var emailBox: FieldView!
    @IBOutlet weak var backView: UIView!
    
    var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        setUp()
        performGSignIn()
        loadButton()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: false)
    }
    
    func setUp(){
        backView.applyCommonBackgroundStyle()
        
        emailBox.configure(withFieldName: "Email", placeholder: "Enter your email")
        passwordBox.configure(withFieldName: "Password", placeholder: "Enter your password")
        
        loginButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        loginButton.buttonLabel.text = "Sign in"
        
        googleButton.layer.cornerRadius = 10
        googleButton.colorScheme = .light
        //        googleButton.clipsToBounds = true
        googleButton.layer.borderWidth = 1
        googleButton.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func loadButton(){
        loginButton.tapAction = {[weak self] in
            guard let self = self else { return }
            
            let email = self.emailBox.inputType.text ?? ""
            let password = self.passwordBox.inputType.text ?? ""
            let rememberMe = self.checkBox.isRectangleFilled
            
            self.viewModel.loginUser(email: email, password: password, rememberMe: rememberMe) { result in
                switch result {
                case .success:
                    // Login successful
                    print("Login successful")
                    
                    // Example: Check login status and navigate to the next screen
                    if self.viewModel.isUserLoggedIn() {
                        self.navigationController?.setViewControllers([TabBarViewController()], animated: false)
                    } else {
                        // Handle as needed
                    }
                    
                case .failure(let error):
                    // Show an alert indicating login failure
                    self.showAlert(message: "Login failed. Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func performGSignIn(){
        let googleSignInButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(googleSignInPressed(_:)))
        googleButton.addGestureRecognizer(googleSignInButtonTapGesture)
    }
    
    @objc func googleSignInPressed(_ sender: UITapGestureRecognizer) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                // Handle the error
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                // Handle missing user or ID token
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    // Handle sign-in error
                    print("Google Sign-In Error: \(error.localizedDescription)")
                    return
                }
                if let currentUser = Auth.auth().currentUser {
                    currentUser.link(with: credential) { authResult, error in
                        if let error = error {
                            // Handle linking error
                            print("Error linking Google credential: \(error.localizedDescription)")
                            return
                        }
                        print("Google credential linked successfully")
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    }
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

