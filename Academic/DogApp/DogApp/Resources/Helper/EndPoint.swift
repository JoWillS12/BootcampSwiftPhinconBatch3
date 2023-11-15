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
    case myPet
    case myPost
    case getUser
    case getProfile
    case getPlace
    case getNearby
    
    func path() -> String {
        switch self {
        case .register:
            return "api/register"
        case .login:
            return "api/login"
        case .myPet:
            return "api/getDog"
        case .myPost:
            return "api/getPosted"
        case .getUser:
            return "api/getUser"
        case .getProfile:
            return "api/getProfile"
        case .getPlace:
            return "api/getPlace"
        case .getNearby:
            return "api/getNearby"
        }
    }
    
    func methode() -> HTTPMethod {
        switch self {
        case .register, .login:
            return .post
        case .myPet, .myPost, .getUser, .getProfile, .getPlace, .getNearby:
            return .get
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
        case .myPet, .myPost, .getUser, .getProfile, .getPlace, .getNearby:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .register, .login, .myPet, .myPost, .getUser, .getProfile, .getPlace, .getNearby:
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
