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
    case getBundles
    
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
        case .getBundles:
            return "bundles"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .getAgents,.getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getBundles, .getSpray:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getAgents, .getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getSpray, .getBundles:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getAgents, .getBuddies, .getMaps, .getTier, .getWeapon, .getGear, .getSpray, .getBundles:
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
    static var userDef = UserDefaults.standard
}

class AppSetting {
    static let shared = AppSetting()
    
    var selectedItem: [CartItem] {
        get {
            if let data = BaseConstant.userDef.data(forKey: "Items"),
               let items = try? JSONDecoder().decode([CartItem].self, from: data) {
                return items
            } else {
                return []
            }
        }
        set(newItems) {
            if let data = try? JSONEncoder().encode(newItems) {
                BaseConstant.userDef.set(data, forKey: "Items")
                BaseConstant.userDef.synchronize()
            }
        }
    }
}
