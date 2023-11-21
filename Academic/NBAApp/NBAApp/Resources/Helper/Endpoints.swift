//
//  Endpoints.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import Foundation
import Alamofire

enum Endpoint {
    case getAgents
    case getBuddies
    case getMaps
    case getTier
    case getGear
    case getWeapon
    case getSpray
    
    func path() -> String {
        switch self {
        case .getAgents:
            return "agents"
        case .getBuddies:
            return "buddies"
        case .getMaps:
            return "maps"
        case .getTier:
            return "competitivetiers"
        case .getGear:
            return "gear"
        case .getWeapon:
            return "weapons"
        case .getSpray:
            return "sprays"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .getAgents,.getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getSpray:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAgents, .getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getSpray:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getAgents, .getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getSpray:
            let params: HTTPHeaders = [
                "Content-Type": "Application/json"]
            return params
        }
    }
    
    func urlString() -> String {
        return BaseConstant.host + self.path()
    }
}

class BaseConstant {
    static var host = "https://valorant-api.com/v1/"
}
