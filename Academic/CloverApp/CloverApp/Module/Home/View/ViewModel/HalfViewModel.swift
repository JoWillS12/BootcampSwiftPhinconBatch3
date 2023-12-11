//
//  HalfViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class HalfViewModel {
    private let halfRef = Database.database().reference().child("download")
    private let usersRef = Database.database().reference().child("users")
    var download: [Download] = []
    
    func downloadMovie(movieId: Int, movieName: String, moviePic: String, movieGenre: String, movieYear: String, completion: @escaping (Error?) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let download: [String: Any] = [
                "movieId": movieId,
                "movieName": movieName,
                "moviePic": moviePic,
                "movieGenre": movieGenre,
                "movieYear": movieYear
            ]
            
            let userDownloadRef = halfRef.child(userUID).childByAutoId()
            userDownloadRef.setValue(download) { (error, ref) in
                completion(error)
            }
        }
    }
}
