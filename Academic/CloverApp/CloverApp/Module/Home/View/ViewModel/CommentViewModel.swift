//
//  CommentViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CommentsViewModel {
    private let commentsRef = Database.database().reference().child("comments")
    private let usersRef = Database.database().reference().child("users")
    var comments: [Comment] = []
    
    func fetchComments(forMovieID movieID: Int, completion: @escaping () -> Void) {
        let commentsQuery = commentsRef.queryOrdered(byChild: "movieId").queryEqual(toValue: movieID)
        
        commentsQuery.observe(.value) { (snapshot) in
            var newComments: [Comment] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let comment = Comment(snapshot: snapshot)
                    newComments.append(comment)
                }
            }
            
            self.comments = newComments
            completion()
        }
    }
    
    func addComment(movieID: Int, commentText: String, currentUser: User?, completion: @escaping (Error?) -> Void) {
        guard let currentUser = currentUser else {
            completion(nil)
            return
        }
        
        let userRef = usersRef.child(currentUser.uid)
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any],
                  let nickname = userData["nickname"] as? String else {
                completion(nil)
                return
            }
            
            let commentKey = self.commentsRef.childByAutoId().key
            
            let commentData: [String: Any] = [
                "userId": currentUser.uid,
                "movieId": movieID,
                "username": nickname,
                "text": commentText,
                "timestamp": ServerValue.timestamp()
            ]
            
            self.commentsRef.child(commentKey!).setValue(commentData) { (error, ref) in
                completion(error)
            }
        }
    }
}
