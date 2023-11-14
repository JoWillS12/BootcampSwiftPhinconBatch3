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
        
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            fieldName.font = customFont
        }
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
        self.addSubview(view)
    }
    
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        inputType.inputView = datePicker
    }
}
