//
//  NetworkManager.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    
    func makeAPICall<T: Decodable>(endpoint: Endpoint,
                                   completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(endpoint.urlString(),
                   method: endpoint.methode(),
                   parameters: endpoint.parameters,
                   encoding: JSONEncoding.default,
                   headers: endpoint.headers).validate().responseDecodable(of: T.self) { (response) in
        
            guard let item = response.value else {
                completion(.failure(response.error as! Error))
                return
            }
            completion(.success(item))
        }
                
    }
    
}
