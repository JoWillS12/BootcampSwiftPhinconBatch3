//
//  DownloadViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DownloadViewModel{
    
    private let downloadRef = Database.database().reference().child("download")
    private let usersRef = Database.database().reference().child("users")
    var downloads: [Download] = []
    
    func fetchDownload(completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let userDownloadRef = downloadRef.child(userUID)
            
            // Observe changes in the user's bookmarks
            userDownloadRef.observeSingleEvent(of: .value) { (snapshot) in
                self.downloads.removeAll() // Clear existing bookmarks
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot {
                        let bookmark = Download(snapshot: snapshot)
                        self.downloads.append(bookmark)
                    }
                }
                
                completion(nil)
            } withCancel: { (error) in
                completion(error)
            }
        }
    }
    
    func deleteDownload(movieId: Int, completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let userDownloadRef = downloadRef.child(userUID)
            
            // Remove the data at the specified reference
            userDownloadRef.queryOrdered(byChild: "movieId").queryEqual(toValue: movieId).observeSingleEvent(of: .value) { (snapshot) in
                if let childSnapshot = snapshot.children.allObjects.first as? DataSnapshot {
                    userDownloadRef.child(childSnapshot.key).removeValue { (error, _) in
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
