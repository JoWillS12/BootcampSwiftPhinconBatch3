//
//  CustomTextField.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import Foundation
import UIKit

class CustomEmailTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    private func commonSetup() {
        // Customize appearance and behavior for email text field
        placeholder = "Email"
        borderStyle = .roundedRect
        keyboardType = .emailAddress
        autocapitalizationType = .none
    }
}

class CustomPasswordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    private func commonSetup() {
        // Customize appearance and behavior for password text field
        placeholder = "Password"
        borderStyle = .roundedRect
        isSecureTextEntry = true
    }
}
