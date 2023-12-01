//
//  Endpoint.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import Foundation
import Alamofire

enum Endpoint {
    
    case nowPlaying
    case genre
    case trending
    case topRated
    case popular
    case upcoming
    
    func path() -> String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .genre:
            return "genre/movie/list"
        case .trending:
            return "trending/movie/day"
        case .topRated:
            return "movie/top_rated"
        case .popular:
            return "movie/popular"
        case .upcoming:
            return "movie/upcoming"
        }
    }
    
    func method() -> HTTPMethod {
        switch self {
        case .nowPlaying, .genre, .trending, .topRated, .popular, .upcoming:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .nowPlaying, .genre, .trending, .topRated, .popular, .upcoming:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        let params: HTTPHeaders = [
            "content-type": "application/json",
            "accept": "application/json",
            "Authorization": "\(loadTMDBTokenKey())"
        ]
        return params    }
    
    func urlString() -> String {
        let basePath = BaseConstant.host + self.path()
        let separator = basePath.contains("?") ? "&" : "?"
        return basePath + separator + "api_key=" + loadTMDBApiKey()
    }
    
    func loadTMDBApiKey() -> String {
        guard let secretPath = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let secretDict = NSDictionary(contentsOfFile: secretPath),
              let apiKey = secretDict["APIKey"] as? String else {
            fatalError("Unable to load TMDB API key from Secret.plist")
        }
        return apiKey
    }
    func loadTMDBTokenKey() -> String {
        guard let secretPath = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let secretDict = NSDictionary(contentsOfFile: secretPath),
              let tokenKey = secretDict["TOKENKey"] as? String else {
            fatalError("Unable to load TMDB TOKEN key from Secret.plist")
        }
        return tokenKey
    }
}

class BaseConstant {
    static var host = "https://api.themoviedb.org/3/"
}

