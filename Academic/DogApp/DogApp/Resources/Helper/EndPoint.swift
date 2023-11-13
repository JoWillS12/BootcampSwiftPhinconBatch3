//
//  EndPoint.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
//

import Foundation
import Alamofire

enum Endpoint {
    case register(param: RegisterParam)
    case login(param: LoginParam)
    
    func path() -> String {
        switch self {
        case .register:
            return "api/register"
        case .login:
            return "api/login"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .register, .login:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .register(let param):
            return [
                "username": param.name,
                "email": param.email,
                "password": param.password,
                "image": param.image
            ]
        case .login(let param):
            return [
                "email": param.email,
                "password": param.password,
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .register, .login:
            let params: HTTPHeaders = [
                "Content-Type": "application/json"]
            return params
        }
    }
    
    func urlString() -> String {
        return BaseConstant.host + self.path()
    }
    
}

class BaseConstant {
    static var host = "http://localhost:3003/"
}
