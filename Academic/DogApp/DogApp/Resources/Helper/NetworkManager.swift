//
//  NetworkManager.swift
//  DogApp
//
//  Created by Joseph William Santoso on 13/11/23.
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
                   headers: endpoint.headers).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

