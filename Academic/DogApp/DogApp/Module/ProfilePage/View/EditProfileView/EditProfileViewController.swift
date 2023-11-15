//
//  EditProfileViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: CircleView!
    @IBOutlet weak var userName: FieldView!
    @IBOutlet weak var userAddress: FieldView!
    @IBOutlet weak var customButton: CustomButton!
    
    var profileData: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateProfile()
        fetchData()
        customButton.buttonLabel.text = "Save"
        customButton.tapAction = {[weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    func updateProfile() {
        // Assuming profileView has name and profileImage properties
        if let profile = profileData.first {
            userName.inputType.text = profile.name
            userName.fieldName.text = "Name"
            userAddress.inputType.text = profile.city
            userAddress.fieldName.text = "Location"
            profileImage.profileImage.image = UIImage(named: profile.image)
        }
    }
    
    func fetchData(){
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
}
