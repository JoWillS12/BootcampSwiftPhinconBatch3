//
//  SprayContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import Foundation

// MARK: - Sprays
struct Sprays: Codable {
    let status: Int
    let data: [SprayData]
}

// MARK: - Datum
struct SprayData: Codable {
    let uuid, displayName: String
    let category: Category?
    let themeUUID: String?
    let isNullSpray, hideIfNotOwned: Bool
    let displayIcon: String
    let fullIcon, fullTransparentIcon, animationPNG: String?
    let animationGIF: String?
    let assetPath: String
    let levels: [SprayLevel]

    enum CodingKeys: String, CodingKey {
        case uuid, displayName, category
        case themeUUID = "themeUuid"
        case isNullSpray, hideIfNotOwned, displayIcon, fullIcon, fullTransparentIcon
        case animationPNG = "animationPng"
        case animationGIF = "animationGif"
        case assetPath, levels
    }
}

enum Category: String, Codable {
    case eAresSprayCategoryContextual = "EAresSprayCategory::Contextual"
}

// MARK: - Level
struct SprayLevel: Codable {
    let uuid: String
    let sprayLevel: Int
    let displayName: String
    let displayIcon: String?
    let assetPath: String
}
