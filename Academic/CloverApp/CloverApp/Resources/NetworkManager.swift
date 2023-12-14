//
//  NetworkManager.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import Foundation
import Alamofire
import Firebase

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    
    func makeAPICall<T: Codable>(endpoint: Endpoint,
                                 completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(endpoint.urlString(),
                   method: endpoint.method(),
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

class OpenAIAPIManager {
    static let shared = OpenAIAPIManager()
    
    private let secretFileName = "Secret"
    private let apiKeyKey = "GPT_APIKey"
    private let endpoint = "https://api.openai.com/v1/engines/davinci/completions"
    private init() {}
    
    private var apiKey: String? {
        guard let path = Bundle.main.path(forResource: secretFileName, ofType: "plist"),
              let xml = FileManager.default.contents(atPath: path) else {
            return nil
        }
        
        do {
            let secretDictionary = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainers, format: nil) as? [String: Any]
            return secretDictionary?[apiKeyKey] as? String
        } catch {
            print("Error reading API key from Secret.plist: \(error)")
            return nil
        }
    }
    
    func generateCompletion(conversation: [String], completionHandler: @escaping (Result<String, Error>) -> Void) {
        guard let apiKey = apiKey, let url = URL(string: endpoint) else {
            completionHandler(.failure(NSError(domain: "Invalid URL or API key", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "prompt": conversation.joined(separator: "\n"),  // Join the conversation into a single string
            "max_tokens": 100  // Adjust as needed
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completionHandler(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Response JSON: \(json ?? [:])")  // Add this line for logging
                
                if let choices = json?["choices"] as? [[String: Any]], let text = choices.first?["text"] as? String {
                    completionHandler(.success(text))
                } else {
                    print("Invalid response format: \(String(data: data, encoding: .utf8) ?? "Unable to decode data")")
                    completionHandler(.failure(NSError(domain: "Invalid response format", code: 0, userInfo: nil)))
                }
            } catch {
                print("Error parsing response: \(error)")
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
