//
//  TierContents.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import Foundation

// MARK: - Tiers
struct Tiers: Codable {
    let status: Int
    let data: [TierData]
}

// MARK: - Datum
struct TierData: Codable {
    let uuid, assetObjectName: String
    let tiers: [Tier]
    let assetPath: String
}

// MARK: - Tier
struct Tier: Codable {
    let tier: Int
    let tierName: String
    let division: Division
    let divisionName: String
    let color: Color
    let backgroundColor: BackgroundColor
    let smallIcon, largeIcon, rankTriangleDownIcon, rankTriangleUpIcon: String?
}

enum BackgroundColor: String, Codable {
    case d1D1D1Ff = "d1d1d1ff"
    case eec56Aff = "eec56aff"
    case ff5551Ff = "ff5551ff"
    case ffedaaff = "ffedaaff"
    case the00000000 = "00000000"
    case the00C7C0Ff = "00c7c0ff"
    case the1C7245Ff = "1c7245ff"
    case the763Bafff = "763bafff"
    case the7C5522Ff = "7c5522ff"
    case the828282Ff = "828282ff"
}

enum Color: String, Codable {
    case a5855Dff = "a5855dff"
    case b489C4Ff = "b489c4ff"
    case bb3D65Ff = "bb3d65ff"
    case bbc2C2Ff = "bbc2c2ff"
    case eccf56Ff = "eccf56ff"
    case ffffaaff = "ffffaaff"
    case ffffffff = "ffffffff"
    case the4F514Fff = "4f514fff"
    case the59A9B6Ff = "59a9b6ff"
    case the6Ae2Afff = "6ae2afff"
}

enum Division: String, Codable {
    case eCompetitiveDivisionASCENDANT = "ECompetitiveDivision::ASCENDANT"
    case eCompetitiveDivisionBRONZE = "ECompetitiveDivision::BRONZE"
    case eCompetitiveDivisionDIAMOND = "ECompetitiveDivision::DIAMOND"
    case eCompetitiveDivisionGOLD = "ECompetitiveDivision::GOLD"
    case eCompetitiveDivisionIMMORTAL = "ECompetitiveDivision::IMMORTAL"
    case eCompetitiveDivisionINVALID = "ECompetitiveDivision::INVALID"
    case eCompetitiveDivisionIRON = "ECompetitiveDivision::IRON"
    case eCompetitiveDivisionPLATINUM = "ECompetitiveDivision::PLATINUM"
    case eCompetitiveDivisionRADIANT = "ECompetitiveDivision::RADIANT"
    case eCompetitiveDivisionSILVER = "ECompetitiveDivision::SILVER"
    case eCompetitiveDivisionUNRANKED = "ECompetitiveDivision::UNRANKED"
}
