//
//  AuthViewModel.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
//

import Foundation

class AuthViewModel {
    
    // MARK: - Properties
    
    let apiService = NetworkManager.shared
    
    // MARK: - Public Methods
    
    func registerUser(param: RegisterParam, completion: ((User) -> Void)?) {
        apiService.makeAPICall(endpoint: .register(param: param)) { [weak self] (response: Result<User, Error>) in
            self?.handleAPIResponse(response: response, completion: completion)
        }
    }
    
    func loginUser(param: LoginParam, completion: ((LoginData) -> Void)?) {
        apiService.makeAPICall(endpoint: .login(param: param)) { [weak self] (response: Result<LoginData, Error>) in
            self?.handleAPIResponse(response: response, completion: completion)
        }
    }
    
    // MARK: - Private Methods
    
    private func handleAPIResponse<T>(response: Result<T, Error>, completion: ((T) -> Void)?) {
        switch response {
        case .success(let data):
            completion?(data)
        case .failure(let error):
            print("API Request Error: \(error.localizedDescription)")
        }
    }
}

