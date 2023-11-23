//
//  AuthContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 22/11/23.
//

import Foundation

struct User: Codable {
    var email: String
    var password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
