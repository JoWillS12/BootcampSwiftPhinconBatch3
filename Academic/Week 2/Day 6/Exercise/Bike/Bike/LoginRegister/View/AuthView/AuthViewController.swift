//
//  AuthViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController, AuthSliderDelegate {
    
    @IBOutlet weak var authenticSlider: AuthSlider!
    @IBOutlet weak var emailField: InputField!
    @IBOutlet weak var passwordField: InputField!
    @IBOutlet weak var buttonState: UIButton!
    @IBOutlet weak var bigLabel: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        emailField.labelType.text = "Email"
        passwordField.labelType.text = "Password"
        authenticSlider.delegate = self
        
        buttonState.setTitle("REGISTER NOW", for: .normal)
        authenticSlider.authType.text = "LOGIN"
        bigLabel.text = "Login"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is signed in with uid: \(user.uid)")
            } else {
                print("User is not signed in")
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    @IBAction func changeToRegister(_ sender: Any) {
        if buttonState.currentTitle == "REGISTER NOW" {
            // Change the button title to "Login Now"
            buttonState.setTitle("LOGIN NOW", for: .normal)
            authenticSlider.authType.text = "REGISTER"
            bigLabel.text = "Register"
        } else{
            // Change the button title to "Register Now"
            buttonState.setTitle("REGISTER NOW", for: .normal)
            authenticSlider.authType.text = "LOGIN"
            bigLabel.text = "Login"
        }
    }
    
}

extension AuthViewController: LoadingDelegate{
    
    func thumbReachedDestination() {
        if buttonState.currentTitle == "LOGIN NOW" {
            if let email = emailField.fieldType.text, let password = passwordField.fieldType.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        let vc = ErrorViewController()
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigationController?.present(vc, animated: true)
                        print("Registration error: \(error.localizedDescription)")
                        self.authenticSlider.returnInitialLocationAnimated(true)
                    } else {
                        let vc = LoadingViewController()
                        vc.delegate = self
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigationController?.present(vc, animated: true)
                    }
                }
            }
        } else {
            if let email = emailField.fieldType.text, let password = passwordField.fieldType.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        let vc = ErrorViewController()
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigationController?.present(vc, animated: true)
                        print("Login error: \(error.localizedDescription)")
                        self.authenticSlider.returnInitialLocationAnimated(true)
                    } else {
                        let vc = LoadingViewController()
                        vc.delegate = self
                        vc.modalTransitionStyle = .coverVertical
                        vc.modalPresentationStyle = .overCurrentContext
                        self.navigationController?.present(vc, animated: true)
                    }
                }
            }
        }
    }
    
    func thumbCurrentPosition(_ position: CGFloat) {
    }
    
    func dismissPopupAndTransition() {
        self.transitionToHomeViewController()
    }
    
    func transitionToHomeViewController() {
        let vc = TabBarController()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
