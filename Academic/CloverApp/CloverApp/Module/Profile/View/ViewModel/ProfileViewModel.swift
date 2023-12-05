//
//  ProfileViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import Foundation
import Firebase
import FirebaseDatabase

class ProfileViewModel {
    let usersRef = Database.database().reference().child("users")
    
    func fetchUserData(for userId: String, completion: @escaping (Result<ProfileData, Error>) -> Void) {
        let userRef = Database.database().reference().child("users").child(userId)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            print("Snapshot value:", snapshot.value)
            if let userData = snapshot.value as? [String: Any],
               let nameLabel = userData["nameLabel"] as? String,
               let nickname = userData["nickname"] as? String,
               let favMovie = userData["favoriteMovie"] as? String {
                let user = ProfileData(nameLabel: nameLabel, nickname: nickname, favoriteMovie: favMovie)
                completion(.success(user))
            } else {
                let parsingError = NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data"])
                completion(.failure(parsingError))
            }
        }
    }
    
    func updateUserData(favoriteMovie: String, nickname: String, nameLabel: String, profilePic: UIImage, phoneNum: String, completion: @escaping (Result<Void, Error>) -> Void) {
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
                    if let profileImageData = profilePic.pngData() {
                                        UserDefaults.standard.set(profileImageData, forKey: "userPic")
                                    }
                    UserDefaults.standard.set(phoneNum, forKey: "userPhoneNumber")
                }
            }
        }
    }
}



