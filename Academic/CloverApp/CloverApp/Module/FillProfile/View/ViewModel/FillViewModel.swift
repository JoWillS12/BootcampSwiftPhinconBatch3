//
//  FillViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import Foundation
import Firebase
import FirebaseDatabase

class FillViewModel{
    
    let usersRef = Database.database().reference().child("users")

    func updateUserData(favoriteMovie: String, nickname: String, nameLabel: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let userUID = Auth.auth().currentUser?.uid {
            let user = [
                "favoriteMovie": favoriteMovie,
                "nickname": nickname,
                "nameLabel": nameLabel
            ]
            
            // Reference to the current user's data in the database
            let userRef = usersRef.child(userUID)
            userRef.setValue(user) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
}
