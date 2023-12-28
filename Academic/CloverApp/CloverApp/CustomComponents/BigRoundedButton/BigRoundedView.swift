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
        layer.addBorder(width: 2.0, color: borderColor, cornerRadius: 16.0)
        // Apply text color
        buttonName.textColor = textColor
        addSubview(view)
    }
}

