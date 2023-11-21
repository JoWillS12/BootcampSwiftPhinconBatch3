//
//  HomeContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 17/11/23.
//

import Foundation
import UIKit

// MARK: - Valorant
struct Valorant: Codable {
    let status: Int
    let data: [ValorantData]
}

// MARK: - Datum
struct ValorantData: Codable {
    let uuid, displayName, description, developerName: String
    let characterTags: [String]?
    let displayIcon, displayIconSmall: String
    let bustPortrait, fullPortrait, fullPortraitV2: String?
    let killfeedPortrait: String
    let background: String?
    let backgroundGradientColors: [String]
    let assetPath: String
    let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, isBaseContent: Bool
    let role: Role?
    let recruitmentData: RecruitmentData?
    let abilities: [Ability]
    let voiceLine: String?
}

// MARK: - Ability
struct Ability: Codable {
    let slot: Slot
    let displayName, description: String
    let displayIcon: String?
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}

// MARK: - RecruitmentData
struct RecruitmentData: Codable {
    let counterID, milestoneID: String
    let milestoneThreshold: Int
    let useLevelVpCostOverride: Bool
    let levelVpCostOverride: Int
    let startDate, endDate: String
    
    enum CodingKeys: String, CodingKey {
        case counterID = "counterId"
        case milestoneID = "milestoneId"
        case milestoneThreshold, useLevelVpCostOverride, levelVpCostOverride, startDate, endDate
    }
}

// MARK: - Role
struct Role: Codable {
    let uuid: String
    let displayName: DisplayName
    let description: String
    let displayIcon: String
    let assetPath: String
}

enum DisplayName: String, Codable {
    case controller = "Controller"
    case duelist = "Duelist"
    case initiator = "Initiator"
    case sentinel = "Sentinel"
}
