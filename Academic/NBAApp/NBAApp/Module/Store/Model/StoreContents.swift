//
//  StoreContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import Foundation

// MARK: - Bundles
struct Bundles: Codable {
    let status: Int
    let data: [BundleData]
}

// MARK: - Datum
struct BundleData: Codable {
    let uuid, displayName: String
    let displayNameSubText: String?
    let description: String
    let extraDescription, promoDescription: String?
    let useAdditionalContext: Bool
    let displayIcon, displayIcon2: String
    let verticalPromoImage: String?
    let assetPath: String
}

// MARK: - Buddies
struct Buddies: Codable {
    let status: Int
    let data: [BuddiesData]
}

// MARK: - Datum
struct BuddiesData: Codable {
    let uuid, displayName: String
    let isHiddenIfNotOwned: Bool
    let themeUUID: String?
    let displayIcon: String
    let assetPath: String
    let levels: [BuddiesLevel]

    enum CodingKeys: String, CodingKey {
        case uuid, displayName, isHiddenIfNotOwned
        case themeUUID = "themeUuid"
        case displayIcon, assetPath, levels
    }
}

// MARK: - Level
struct BuddiesLevel: Codable {
    let uuid: String
    let charmLevel: Int
    let hideIfNotOwned: Bool
    let displayName: String
    let displayIcon: String
    let assetPath: String
}

// MARK: - Cart Items
struct CartItem: Codable {
    var itemType: ItemType
    var itemId: String
    var itemImage: String?
    var itemName: String

    enum ItemType: String, Codable {
        case bundle
        case buddies
    }

    // You can add more properties as needed, such as price, name, etc., based on your requirements.

    init(itemType: ItemType, itemId: String, itemImage: String, itemName: String) {
        self.itemType = itemType
        self.itemId = itemId
        self.itemImage = itemImage
        self.itemName = itemName
    }
}


