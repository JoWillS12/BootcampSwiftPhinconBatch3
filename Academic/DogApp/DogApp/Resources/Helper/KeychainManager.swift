//
//  KeychainManager.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
//

import Foundation
import Security
import KeychainAccess

class KeychainService {
    static let shared = KeychainService()
    
    private let keychain = Keychain(service: "com.your.app.keychain")
    
    private init() {}
    
    func saveUserCredentials(user: User) {
        keychain["email"] = user.email
        keychain["id"] = "\(user.id)"
        // Save other user-related data if needed
    }
    
    func getUserCredentials() -> (email: String?, id: String?) {
        return (keychain["email"], keychain["id"])
    }
    
    func clearUserCredentials() {
        keychain["email"] = nil
        keychain["id"] = nil
        // Clear other user-related data if needed
    }
}
