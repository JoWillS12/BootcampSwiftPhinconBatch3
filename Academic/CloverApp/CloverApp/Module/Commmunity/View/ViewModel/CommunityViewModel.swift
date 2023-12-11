//
//  CommunityViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit
import FirebaseStorage
import AVFoundation

class CommunityViewModel{
    let databaseRef = Database.database().reference()
    var currentUserNickname: String?
    
    func sendTextMessage(userPicture: String, text: String) {
        guard let userName = currentUserNickname else {
            print("Error: Current user nickname is nil")
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let message = ChatMessage(userName: userName, userPicture: userPicture, contentType: .text, content: ChatMessage.Content(text: text), timestamp: timestamp)
        saveMessageToFirebase(message: message)
    }
    
    func sendImageMessage(userPicture: String, imageURL: String) {
        guard let userName = currentUserNickname else {
            print("Error: Current user nickname is nil")
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let message = ChatMessage(userName: userName, userPicture: userPicture, contentType: .image, content: ChatMessage.Content(imageURL: imageURL), timestamp: timestamp)
        saveMessageToFirebase(message: message)
    }
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (String?) -> Void) {
        // Convert the image to data
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }
        
        // Create a unique filename for the image
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(imageName)")
        
        // Upload the image to Firebase Storage
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image to Firebase Storage: \(error.localizedDescription)")
                completion(nil)
            } else {
                // Get the download URL for the image
                storageRef.downloadURL { (url, error) in
                    if let imageURL = url?.absoluteString {
                        completion(imageURL)
                    } else {
                        print("Error getting image download URL: \(error?.localizedDescription ?? "")")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func sendAudioMessage(userPicture: String, audioURL: String) {
        guard let userName = currentUserNickname else {
            print("Error: Current user nickname is nil")
            return
        }
        let timestamp = Date().timeIntervalSince1970
        let message = ChatMessage(userName: userName, userPicture: userPicture, contentType: .audio, content: ChatMessage.Content(audioURL: audioURL), timestamp: timestamp)
        saveMessageToFirebase(message: message)
    }
    
    func uploadAudioToFirebase(audioURL: URL, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference().child("audio/\(UUID().uuidString).wav")

        storageRef.putFile(from: audioURL, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading audio to Firebase Storage: \(error.localizedDescription)")
                completion(nil)
            } else {
                // Get the download URL for the audio
                storageRef.downloadURL { (url, error) in
                    if let audioURL = url?.absoluteString {
                        completion(audioURL)
                    } else {
                        print("Error getting audio download URL: \(error?.localizedDescription ?? "")")
                        completion(nil)
                    }
                }
            }
        }
    }
    
    private func saveMessageToFirebase(message: ChatMessage) {
        let reference = databaseRef.child("community").childByAutoId()
        reference.setValue(message.toJSON())
    }
    
    func fetchMessagesFromFirebase(completion: @escaping ([ChatMessage]) -> Void) {
        let communityRef = databaseRef.child("community")
        
        // Observe changes in the "community" node
        communityRef.observe(.value) { (snapshot) in
            guard snapshot.exists(), let messagesData = snapshot.value as? [String: [String: Any]] else {
                completion([])
                return
            }
            
            var messages: [ChatMessage] = []
            
            for (_, messageData) in messagesData {
                if let message = ChatMessage.fromJSON(messageData) {
                    messages.append(message)
                }
            }
            
            // Sort messages by timestamp
            messages.sort { $0.timestamp < $1.timestamp }
            
            completion(messages)
        }
    }
    
}
