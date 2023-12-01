//
//  AuthViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import Foundation
import Firebase

class AuthViewModel {
    
    func registerUser(email: String, password: String, confirmPassword: String, phoneNum: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Validate if passwords match
        guard !phoneNum.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, password == confirmPassword else {
            completion(.failure(AuthError.validationError))
            return
        }
        
        // Create user with Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Registration successful
                completion(.success(()))
                
                // Save registration status and phone number in UserDefaults
                UserDefaults.standard.set(true, forKey: "isUserRegistered")
                UserDefaults.standard.set(phoneNum, forKey: "userPhoneNumber")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func isUserRegistered() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserRegistered")
    }
    
    func loginUser(email: String, password: String, rememberMe: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Login successful
                completion(.success(()))
                
                // Save login state in UserDefaults
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(email, forKey: "currentUserEmail")
                UserDefaults.standard.set(rememberMe, forKey: "RememberMe")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }
    
    func getCurrentUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: "currentUserEmail")
    }
    
    func getRememberMeStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "RememberMe")
    }
}
