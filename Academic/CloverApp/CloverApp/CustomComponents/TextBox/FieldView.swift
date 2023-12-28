//
//  FieldView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class FieldView: UIView {
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var inputType: UITextField!
    
    var datePicker: UIDatePicker?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrangeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrangeView()
        setupDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
extension FieldView{
    func arrangeView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        inputType.layer.borderColor = UIColor.white.cgColor
        inputType.layer.cornerRadius = 10
        inputType.layer.borderWidth = 1
        self.addSubview(view)
        fieldName.font =  CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        inputType.inputView = datePicker
    }
    
    func configure(withFieldName fieldName: String, placeholder: String) {
        self.fieldName.text = fieldName
        self.inputType.placeholder = placeholder
        self.inputType.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
}

