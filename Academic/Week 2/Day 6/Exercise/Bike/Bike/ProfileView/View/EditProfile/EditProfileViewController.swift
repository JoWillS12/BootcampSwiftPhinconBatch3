//
//  EditProfileViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 02/11/23.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userCard: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        saveUserProfile()
    }
}

extension EditProfileViewController{
    func loadUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = databaseRef.child("users").child(uid)
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            if let userData = snapshot.value as? [String: Any] {
                let user = User(
                    username: userData["username"] as? String ?? "",
                    phone: userData["phone"] as? String ?? "",
                    card: userData["card"] as? String ?? "",
                    address: userData["address"] as? String ?? ""
                )
                
                self.updateUI(with: user)
            }
        })
    }
    
    func updateUI(with user: User) {
        userName.text = user.username
        userPhone.text = user.phone
        userCard.text = user.card
        userAddress.text = user.address
    }
    
    func saveUserProfile() {
        guard let uid = Auth.auth().currentUser?.uid,
              let username = userName.text,
              let phone = userPhone.text,
              let card = userCard.text,
              let address = userAddress.text else {
            return
        }
        
        let user = User(username: username, phone: phone, card: card, address: address)
        let userData = user.dictionaryRepresentation()
        
        let userRef = databaseRef.child("users").child(uid)
        userRef.setValue(userData)
    }
}
