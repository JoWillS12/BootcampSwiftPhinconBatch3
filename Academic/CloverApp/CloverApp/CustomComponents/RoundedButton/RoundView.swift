//
//  RoundView.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit

class RoundView: UIView {
    
    @IBOutlet weak var buttonName: UILabel!
    @IBOutlet weak var buttonImage: UIImageView!
    
    var tapAction: (()->Void)?
    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    // Background color property
    var backgroundColorOverride: UIColor = .clear {
        didSet {
            buttonName.backgroundColor = backgroundColorOverride
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
        layer.addBorder(width: 2.0, color: borderColor, cornerRadius: 16.0)
        // Apply background color
        buttonName.backgroundColor = backgroundColorOverride
        buttonName.textColor = textColor
        addSubview(view)
    }
}
