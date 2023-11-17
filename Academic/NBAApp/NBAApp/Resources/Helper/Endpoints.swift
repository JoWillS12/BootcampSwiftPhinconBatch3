//
//  Endpoints.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import Foundation
import Alamofire

enum Endpoint {
    case getBike
    case getHelmet
    
    func path() -> String {
        switch self {
        case .getBike:
            return "api/bike"
        case .getHelmet:
            return "api/helmet"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .getBike,.getHelmet:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getBike, .getHelmet:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getBike, .getHelmet:
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
    static var host = "http://localhost:3002/"
}
