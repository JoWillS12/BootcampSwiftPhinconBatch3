//
//  PostContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import Foundation

struct CommunityPost: Codable {
    let userName, userProfile, postDate, postImage: String
    let chatNumber: String
}

struct Users: Codable {
    let name: String
}

struct Places: Codable{
    let city, country: String
}
