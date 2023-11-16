//
//  PostContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import Foundation

// MARK: - CommunityPost

struct CommunityPost: Codable {
    let userName: String
    let userProfile: String
    let postDate: String
    let postImage: String
    let chatNumber: String
}

// MARK: - Users

struct Users: Codable {
    let name: String
}

// MARK: - Places

struct Places: Codable {
    let city: String
    let country: String
}

