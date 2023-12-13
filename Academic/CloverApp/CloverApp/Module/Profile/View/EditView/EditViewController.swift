//
//  EditViewController.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit
import FirebaseAuth

class EditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImage: CircleView!
    @IBOutlet weak var favoriteMovieField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var updateButton: ButtonView!
    
    var vm = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
        loadData()
        updateData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        favoriteMovieField.delegate = self
        nicknameField.delegate = self
        nameField.delegate = self
        phoneNumberField.delegate = self
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUp(){
        updateButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        updateButton.buttonLabel.text = "Update"
        nameField.placeholder = "Your Name"
        phoneNumberField.placeholder = "Your Phone Number"
        nicknameField.placeholder = "Your Nickname"
        favoriteMovieField.placeholder = "Your Favorite Movie"
    }
    
    func loadData(){
        if let currentUser = Auth.auth().currentUser {
            emailLabel.text = currentUser.email
            
            if let phoneNum = UserDefaults.standard.string(forKey: "userPhoneNumber") {
                phoneNumberField.text = phoneNum
            } else {
                // Handle the case where the phone number is not available
                print("Not Available")
            }
            
            vm.fetchUserData(for: currentUser.uid) { result in
                switch result {
                case .success(let user):
                    // Update the UI with the fetched user data
                    self.nameField.text = user.nameLabel
                    self.nicknameField.text = user.nickname
                    self.favoriteMovieField.text = user.favoriteMovie
                case .failure(let error):
                    print("Error fetching user data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateData() {
        updateButton.tapAction = { [weak self] in
            print("tapped!")
            guard let self = self else { return }
            
            let favoriteMovie = self.favoriteMovieField.text ?? ""
            let nickname = self.nicknameField.text ?? ""
            let nameLabel = self.nameField.text ?? ""
            let profilePic = self.profileImage.profileImage.image ?? UIImage(systemName: "profile")
            let phoneNum = self.phoneNumberField.text ?? ""
            
            self.vm.updateUserData(
                favoriteMovie: favoriteMovie,
                nickname: nickname,
                nameLabel: nameLabel,
                profilePic: profilePic ?? UIImage(systemName: "profile")!,
                phoneNum: phoneNum
            ) { result in
                switch result {
                case .success:
                    // Update successful
                    print("User data updated successfully")
                    if let profileImageData = profilePic?.pngData() {
                        UserDefaults.standard.set(profileImageData, forKey: "userPic")
                    }
                    
                    UserDefaults.standard.set(phoneNum, forKey: "userPhoneNumber")
                    self.navigationController?.popViewController(animated: false)
                    
                case .failure(let error):
                    // Show an alert indicating update failure
                    self.showAlert(message: "Update failed. Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
