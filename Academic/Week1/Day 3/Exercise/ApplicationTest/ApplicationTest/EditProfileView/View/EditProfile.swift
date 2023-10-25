//
//  EditProfile.swift
//  ApplicationTest
//
//  Created by Joseph William Santoso on 25/10/23.
//

import Foundation
import UIKit

protocol PassingDataDelegate: AnyObject{
    func passData(data: Profile)
}

class EditProfileViewController: UIViewController{
    
    weak var delegate: PassingDataDelegate?
    
    
    @IBOutlet weak var nameEditor: UITextField!
    
    @IBOutlet weak var birthdayEditor: UITextField!
    
    @IBOutlet weak var phoneEditor: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        let name = nameEditor.text ?? ""
        let birth = birthdayEditor.text ?? ""
        let phone = phoneEditor.text ?? ""
        
        self.delegate?.passData(data: Profile(name: name, birth: birth, phone: phone))
        
        self.dismiss(animated: true, completion: nil)
    }

    
    
}
