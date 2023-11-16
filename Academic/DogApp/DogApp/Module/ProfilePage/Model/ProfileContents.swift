//
//  ProfileContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import Foundation

// MARK: - Profile Model
struct Profile: Codable {
    let name, image, city: String
}

// MARK: - Nearby Model
struct Nearby: Codable {
    let image, name, distance: String
}

