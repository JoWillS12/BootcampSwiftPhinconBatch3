//
//  FillViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit
import FirebaseAuth
import Firebase

class FillViewController: UIViewController {
    
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
        
        // Do any additional setup after loading the view.
        loadButton()
        loadUserData()
        setUp()
    }
    
    @IBAction func skipButton(_ sender: Any) {
        self.navigationController?.pushViewController(HomeViewController(), animated: false)
    }
    
    func setUp(){
        updateButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        updateButton.buttonLabel.text = "Update"
        
        nameLabel.attributedPlaceholder = NSAttributedString(string: "Enter your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        Nickname.attributedPlaceholder = NSAttributedString(string: "Enter your Nickname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        favoriteMovie.attributedPlaceholder = NSAttributedString(string: "Enter your Favorite Movie", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
            
            self.viewModel.updateUserData(favoriteMovie: favoriteMovie, nickname: nickname, nameLabel: nameLabel) { result in
                switch result {
                case .success:
                    // Update successful
                    print("User data updated successfully")
                    self.navigationController?.pushViewController(TabBarViewController(), animated: false)
                    // Perform any additional actions after updating data
                    
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
