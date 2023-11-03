//
//  NetworkManager.swift
//  Bike
//
//  Created by Joseph William Santoso on 03/11/23.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    
    func makeAPICall<T: Decodable>(urlString: String,
                                   parameters: [String: Any] = [:],
                                   headers: [String: String] = [:],
                                   method: HTTPMethod = .get,
                                   encoding: ParameterEncoding = JSONEncoding.default,
                                   completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(urlString).validate().responseDecodable(of: T.self) { (response) in
            
            guard let item = response.value else {
                completion(.failure(response.error as! Error))
                return
            }
            completion(.success(item))
        }
        
    }
    
}
