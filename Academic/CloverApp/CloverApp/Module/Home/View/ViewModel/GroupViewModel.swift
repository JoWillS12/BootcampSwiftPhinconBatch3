//
//  GroupViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 06/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class GroupViewModel {
    private let bookmarkRef = Database.database().reference().child("bookmark")
    private let usersRef = Database.database().reference().child("users")
    var book: [Bookmark] = []
    
    func addBookmark(movieId: Int, movieName: String, moviePic: String, completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let bookmark: [String: Any] = [
                "movieId": movieId,
                "movieName": movieName,
                "moviePic": moviePic
            ]
            
            let userBookmarkRef = bookmarkRef.child(userUID).childByAutoId()
            userBookmarkRef.setValue(bookmark) { (error, ref) in
                completion(error)
            }
        }
    }
}
