//
//  FillViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit
import FirebaseAuth
import Firebase

class FillViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var favoriteMovie: UITextField!
    @IBOutlet weak var Nickname: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var profileImage: CircleView!
    @IBOutlet weak var updateButton: ButtonView!
    
    let viewModel = FillViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func skipButton(_ sender: Any) {
        self.navigationController?.pushViewController(HomeViewController(), animated: false)
        let randomUsername = generateRandomName()
        nameLabel.text = randomUsername
        saveUsernameToFirebase(username: randomUsername)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUp(){
        loadButton()
        loadUserData()
        
        updateButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        updateButton.buttonLabel.text = "Update"
        
        nameLabel.attributedPlaceholder = NSAttributedString(string: "Enter your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        Nickname.attributedPlaceholder = NSAttributedString(string: "Enter your Nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        favoriteMovie.attributedPlaceholder = NSAttributedString(string: "Enter your Favorite Movie", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        favoriteMovie.delegate = self
        Nickname.delegate = self
        nameLabel.delegate = self
    }
    
    func loadUserData() {
        // Retrieve the current user's information from Firebase Authentication
        if let currentUser = Auth.auth().currentUser {
            userEmail.text = currentUser.email
            
            // Retrieve phone number from UserDefaults
            if let phoneNumber = UserDefaults.standard.string(forKey: "userPhoneNumber") {
                userPhone.text = phoneNumber
            } else {
                // Handle the case where the phone number is not available
                userPhone.text = "Phone Number Not Available"
            }
        }
    }
    
    func loadButton(){
        updateButton.tapAction = {[weak self] in
            //Save user data in userdefaults account
            guard let self = self else { return }
            
            let favoriteMovie = self.favoriteMovie.text ?? ""
            let nickname = self.Nickname.text ?? ""
            let nameLabel = self.nameLabel.text ?? ""
            let profilePic = self.profileImage.profileImage.image ?? UIImage(systemName: "profile")
            
            self.viewModel.updateUserData(favoriteMovie: favoriteMovie, nickname: nickname, nameLabel: nameLabel, profilePic: (profilePic ?? UIImage(systemName: "profile"))!) { result in
                switch result {
                case .success:
                    // Update successful
                    print("User data updated successfully")
                    self.navigationController?.pushViewController(TabBarViewController(), animated: false)
                    // Perform any additional actions after updating data
                    if let profileImageData = profilePic?.pngData() {
                        UserDefaults.standard.set(profileImageData, forKey: "userPic")
                    }
                case .failure(let error):
                    // Show an alert indicating update failure
                    self.showAlertFailed(message: "Update failed. Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveUsernameToFirebase(username: String) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            showAlertFailed(message: "User not authenticated.")
            return
        }
        
        let userRef = viewModel.usersRef.child(currentUserUID)
        userRef.child("nameLabel").setValue(username) { error, _ in
            if let error = error {
                self.showAlertFailed(message: "Failed to save username to Firebase. Error: \(error.localizedDescription)")
            } else {
                print("Username saved to Firebase: \(username)")
            }
        }
    }
    
    func generateRandomName() -> String {
        let randomNumber = Int.random(in: 100000000..<1000000000)
        return "user\(randomNumber)"
    }
}
