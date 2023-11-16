//
//  PetContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import Foundation

// MARK: - MyPet Model

/// Represents a structure for pet data.
struct MyPet: Codable {
    
    // MARK: - Properties
    
    var petImage: String
    var petName: String
    var petRace: String
    var petBirth: String
    var status: String
}

