//
//  EditProfileViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileImage: CircleView!
    @IBOutlet weak var userName: FieldView!
    @IBOutlet weak var userAddress: FieldView!
    @IBOutlet weak var customButton: CustomButton!
    
    // MARK: - Data
    
    var profileData: [Profile] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update profile UI, fetch data, and configure save button
        updateProfile()
        fetchData()
        configureSaveButton()
    }
    
    // MARK: - Profile Functions
    
    /// Update UI with the first profile data from the array.
    func updateProfile() {
        if let profile = profileData.first {
            userName.inputType.text = profile.name
            userName.fieldName.text = "Name"
            userAddress.inputType.text = profile.city
            userAddress.fieldName.text = "Location"
            profileImage.profileImage.image = UIImage(named: profile.image)
        }
    }
    
    // MARK: - Data Fetching
    
    /// Fetch user profile data from the network.
    func fetchData() {
        NetworkManager.shared.makeAPICall(endpoint: .getUser) { [weak self] (response: Result<[Profile], Error>) in
            switch response {
            case .success(let datas):
                self?.profileData = datas
                self?.updateProfile() // Call the function to update the profile information
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Save Button Configuration
    
    /// Configure the save button with tap action.
    func configureSaveButton() {
        customButton.buttonLabel.text = "Save"
        customButton.tapAction = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
}
