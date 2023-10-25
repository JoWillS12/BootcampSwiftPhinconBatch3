//
//  ViewController.swift
//  ApplicationTest
//
//  Created by Joseph William Santoso on 25/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var headName: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonEdit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
    }

    @IBAction func editButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editProfileView = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        editProfileView.delegate = self
        self.present(editProfileView, animated: true)
    }

    
}

extension ViewController: PassingDataDelegate {
    func passData(data: Profile) {
        headName.text = data.name
        nameLabel.text = data.name
        birthLabel.text = data.birth
        phoneLabel.text = data.phone
    }
    
}

