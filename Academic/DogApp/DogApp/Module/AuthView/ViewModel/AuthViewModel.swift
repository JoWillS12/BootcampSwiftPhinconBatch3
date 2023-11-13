//
//  AuthViewModel.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
//

import Foundation


class AuthViewModel {
    
    let apiService = NetworkManager.shared
    
    func registerUser(param: RegisterParam, completion: ((User) -> Void)?) {
        apiService.makeAPICall(endpoint: .register(param: param)) { (response: Result<User, Error>) in
            switch response {
            case .success(let user):
                completion?(user)
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func loginUser(param: LoginParam, completion: ((LoginData) -> Void)?) {
        apiService.makeAPICall(endpoint: .login(param: param)) { (response: Result<LoginData, Error>) in
            switch response {
            case .success(let token):
                completion?(token)
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
}
