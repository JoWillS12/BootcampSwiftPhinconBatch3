//
//  BookmarkViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 06/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class BookmarkViewModel{
    
    private let bookmarkRef = Database.database().reference().child("bookmark")
    private let usersRef = Database.database().reference().child("users")
    var bookmarks: [Bookmark] = []
    
    func fetchBookmarks(completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let userBookmarkRef = bookmarkRef.child(userUID)
            
            // Observe changes in the user's bookmarks
            userBookmarkRef.observeSingleEvent(of: .value) { (snapshot) in
                self.bookmarks.removeAll() // Clear existing bookmarks
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        let bookmark = Bookmark(snapshot: snapshot)
                        self.bookmarks.append(bookmark)
                    }
                }
                
                completion(nil)
            } withCancel: { (error) in
                completion(error)
            }
        }
    }
    
    func deleteBookmark(movieId: Int, completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let userBookmarkRef = bookmarkRef.child(userUID)
            
            // Remove the data at the specified reference
            userBookmarkRef.queryOrdered(byChild: "movieId").queryEqual(toValue: movieId).observeSingleEvent(of: .value) { (snapshot) in
                if let childSnapshot = snapshot.children.allObjects.first as? DataSnapshot {
                    userBookmarkRef.child(childSnapshot.key).removeValue { (error, _) in
                        completion(error)
                    }
                } else {
                    // Handle the case where the movieId is not found
                    completion(nil)
                }
            } withCancel: { (error) in
                completion(error)
            }
        }
    }
}
