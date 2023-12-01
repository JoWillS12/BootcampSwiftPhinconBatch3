//
//  BigRoundedView.swift
//  C
//
//  Created by Joseph William Santoso on 30/11/23.
//

import UIKit

class BigRoundedView: UIView {

    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var buttonName: UILabel!

    var tapAction: (()->Void)?
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // Text color property
    var textColor: UIColor = .black {
        didSet {
            buttonName.textColor = textColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        tapAction?()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        // Apply border
        layer.borderWidth = 2.0
        layer.cornerRadius = 16.0 // Customize as needed
        layer.masksToBounds = true
        
        // Apply border color
        layer.borderColor = borderColor.cgColor
        
        // Apply text color
        buttonName.textColor = textColor
        addSubview(view)
    }
}

