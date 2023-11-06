//
//  ProductContents.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import Foundation

struct ProductType: Codable {
    var name: String
    var image: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case price
    }
}


