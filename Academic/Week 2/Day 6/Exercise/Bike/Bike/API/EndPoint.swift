//
//  EndPoint.swift
//  Bike
//
//  Created by Joseph William Santoso on 03/11/23.
//

import Foundation
import Alamofire

enum Endpoint {
    case getbike
    case getHistory
    
    func path() -> String {
        switch self {
        case .getbike:
            return "api/bike"
        case .getHistory:
            return "api/gethistory"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .getbike, .getHistory :
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getbike, .getHistory:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getbike, .getHistory:
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
    static var host = "http://localhost:3001/"
    static var hostasli = "https://localhost:3001/"
}
