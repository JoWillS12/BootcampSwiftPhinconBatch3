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

class CommentService {
    static let shared = CommentService()
    let databaseRef = Database.database().reference()

    func sendComment(commentText: String, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid,
              let userName = Auth.auth().currentUser?.displayName else {
            // User is not logged in
            return
        }

        let commentRef = databaseRef.child("comments").childByAutoId()
        let commentData = [
            "userId": userId,
            "userName": userName,
            "commentText": commentText,
            "commentDate": Date().description
        ]
        commentRef.setValue(commentData) { error, _ in
            completion(error)
        }
    }

    func observeComments(completion: @escaping ([Comment]) -> Void) {
        databaseRef.child("comments").observe(.value) { snapshot in
            var comments: [Comment] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let commentData = snapshot.value as? [String: String] {
                    let comment = Comment(
                        id: snapshot.key,
                        userId: commentData["userId"] ?? "",
                        userName: commentData["userName"] ?? "",
                        commentText: commentData["commentText"] ?? "",
                        commentDate: commentData["commentDate"] ?? ""
                    )
                    comments.append(comment)
                }
            }
            completion(comments)
        }
    }
}
