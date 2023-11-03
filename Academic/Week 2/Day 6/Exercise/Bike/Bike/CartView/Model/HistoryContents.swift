//
//  HistoryContents.swift
//  Bike
//
//  Created by Joseph William Santoso on 03/11/23.
//

import Foundation

struct History: Codable{
    var title: String
    var tags: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case tags
    }
}
