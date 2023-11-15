//
//  AddPetViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class AddPetViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var petImage: CircleView!
    @IBOutlet weak var petName: FieldView!
    @IBOutlet weak var petRace: FieldView!
    @IBOutlet weak var petBirth: FieldView!
    @IBOutlet weak var saveButton: BlueView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setupDatePickerToolbar()
        saveButton.tapAction = {[weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func backToPage(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func datePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        if let date = petBirth.datePicker?.date {
            petBirth.inputType.text = formatter.string(from: date)
        }

        petBirth.inputType.resignFirstResponder()
    }
}
extension AddPetViewController: UITextFieldDelegate{
    func setUp(){
        petName.fieldName.text = "Name"
        petRace.fieldName.text = "Race"
        petBirth.fieldName.text = "Birthday"
        petBirth.inputType.delegate = self
        saveButton.buttonTitle.text = "Save"
    }
    
    func setupDatePickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        toolbar.setItems([doneButton], animated: true)
        
        petBirth.inputType.inputAccessoryView = toolbar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == petBirth.inputType {
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            petBirth.inputType.text = formatter.string(from: today)

            // Set the default date in the date picker
            petBirth.datePicker?.date = today

            // Show the date picker
            petBirth.inputType.becomeFirstResponder()
        }
    }
}
