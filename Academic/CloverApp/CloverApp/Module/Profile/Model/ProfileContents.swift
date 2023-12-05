//
//  ProfileContents.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import Foundation

struct ProfileData: Codable {
    var nameLabel, nickname, favoriteMovie: String
    
    enum CodingKeys: String, CodingKey {
        case nameLabel, nickname, favoriteMovie
    }
}

