//
//  AddPetViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class AddPetViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var petImage: CircleView!
    @IBOutlet weak var petName: FieldView!
    @IBOutlet weak var petRace: FieldView!
    @IBOutlet weak var petBirth: FieldView!
    @IBOutlet weak var saveButton: BlueView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the UI and configure save button tap action
        setUp()
        setupDatePickerToolbar()
        saveButton.tapAction = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func backToPage(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Date Picker
    
    @objc func datePickerDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        if let date = petBirth.datePicker?.date {
            petBirth.inputType.text = formatter.string(from: date)
        }
        
        petBirth.inputType.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate

extension AddPetViewController: UITextFieldDelegate {
    
    // MARK: - UI Setup
    
    /// Set up initial UI configurations.
    func setUp() {
        petName.fieldName.text = "Name"
        petRace.fieldName.text = "Race"
        petBirth.fieldName.text = "Birthday"
        petBirth.inputType.delegate = self
        saveButton.buttonTitle.text = "Save"
    }
    
    // MARK: - Date Picker Toolbar
    
    /// Set up a toolbar for the date picker.
    func setupDatePickerToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePressed))
        toolbar.setItems([doneButton], animated: true)
        
        petBirth.inputType.inputAccessoryView = toolbar
    }
    
    // MARK: - Text Field Delegate
    
    /// Handle the beginning of editing for the date text field.
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
