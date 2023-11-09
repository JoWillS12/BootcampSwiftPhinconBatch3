//
//  HistoryContents.swift
//  Bike
//
//  Created by Joseph William Santoso on 03/11/23.
//

import Foundation

struct History: Codable{
    var total: String
    
    enum CodingKeys: String, CodingKey {
        case total
    }
}
