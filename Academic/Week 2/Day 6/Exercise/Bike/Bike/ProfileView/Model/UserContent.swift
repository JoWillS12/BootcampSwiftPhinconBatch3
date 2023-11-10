//
//  UserContent.swift
//  Bike
//
//  Created by Joseph William Santoso on 10/11/23.
//

import Foundation

struct User {
    var username: String
    var phone: String
    var card: String
    var address: String
    
    init(username: String, phone: String, card: String, address: String) {
        self.username = username
        self.phone = phone
        self.card = card
        self.address = address
    }
}

extension User {
    func dictionaryRepresentation() -> [String: Any] {
        return [
            "username": username,
            "phone": phone,
            "card": card,
            "address": address
        ]
    }
}

