//
//  AuthContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
//

import Foundation

// MARK: - User Model

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let userPict: String?  // Optional for registration
    let fullname: String?  // Optional for registration
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case userPict
        case fullname
    }
}

// MARK: - Registration Parameters

struct RegisterParam {
    var name: String
    var email: String
    var password: String
    var image: String
}

// MARK: - Login Parameters

struct LoginParam {
    var email: String
    var password: String
}

// MARK: - Login Response Data Model

struct LoginData: Codable {
    let token: String
}


