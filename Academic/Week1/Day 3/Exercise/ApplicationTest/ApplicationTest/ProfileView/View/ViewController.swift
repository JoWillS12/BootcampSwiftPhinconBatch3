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
        
        if let customFont = loadCustomFont(withName: "28 Days Later", fontSize: 30) {
                headName.font = customFont
            }
        
//        printSystemFonts()
        
        
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
    
        func loadCustomFont(withName fontName: String, fontSize: CGFloat) -> UIFont? {
            if let customFont = UIFont(name: fontName, size: fontSize) {
                return customFont
            } else {
                print("Font not found. Make sure the font is added to your project and specified in Info.plist.")
                return UIFont.systemFont(ofSize: fontSize) // Use a default font if the custom font can't be loaded
            }
        }
    
//    public func printSystemFonts() {
//        // Use this identifier to filter out the system fonts in the logs.
//        let identifier: String = "[SYSTEM FONTS]"
//        // Here's the functionality that prints all the system fonts.
//        for family in UIFont.familyNames as [String] {
//            debugPrint("\(identifier) FONT FAMILY :  \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                debugPrint("\(identifier) FONT NAME :  \(name)")
//            }
//        }
//    }
    
}

