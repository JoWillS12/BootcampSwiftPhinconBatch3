//
//  ProfileViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeImage: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    let imagePickerVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = 240 / 2
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.clipsToBounds = true
        
        fetchEmail()
    }
    
    @IBAction func openEdit(_ sender: Any) {
        let vc = EditProfileViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = AuthViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
            print("User signed out")
        } catch let signOutError as NSError {
            // Handle sign-out error
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        
    }
    
    func fetchEmail(){
        if let currentUser = Auth.auth().currentUser {
            // Get the user's email from Firebase Authentication
            if let emailUser = currentUser.email {
                // Display the email in the label
                userEmail.text = "\(emailUser)"
            } else {
                // Handle the case where the user's email is not available
                userEmail.text = "Email not found"
            }
        } else {
            // Handle the case where no user is logged in
            userEmail.text = "No user logged in"
        }
    }
    
}
