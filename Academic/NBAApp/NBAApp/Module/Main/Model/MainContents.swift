//
//  MainContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 17/11/23.
//

import Foundation
import UIKit

struct SideMenuModel {
    var icon: UIImage
    var title: String
}

// MARK: - Maps
struct Maps: Codable {
    let status: Int
    let data: [MapsData]
}

// MARK: - Datum
struct MapsData: Codable {
    let uuid, displayName: String
    let narrativeDescription: String?
    let tacticalDescription: TacticalDescription?
    let coordinates: String?
    let displayIcon: String?
    let listViewIcon, splash: String
    let assetPath, mapURL: String
    let xMultiplier, yMultiplier, xScalarToAdd, yScalarToAdd: Double
    let callouts: [Callout]?

    enum CodingKeys: String, CodingKey {
        case uuid, displayName, narrativeDescription, tacticalDescription, coordinates, displayIcon, listViewIcon, splash, assetPath
        case mapURL = "mapUrl"
        case xMultiplier, yMultiplier, xScalarToAdd, yScalarToAdd, callouts
    }
}

// MARK: - Callout
struct Callout: Codable {
    let regionName: String
    let superRegionName: SuperRegionName
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let x, y: Double
}

enum SuperRegionName: String, Codable {
    case a = "A"
    case attackerSide = "Attacker Side"
    case b = "B"
    case c = "C"
    case defenderSide = "Defender Side"
    case mid = "Mid"
}

enum TacticalDescription: String, Codable {
    case aBCSites = "A/B/C Sites"
    case aBSites = "A/B Sites"
}
