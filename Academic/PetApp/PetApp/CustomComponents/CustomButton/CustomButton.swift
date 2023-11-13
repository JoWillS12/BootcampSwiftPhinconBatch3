//
//  CustomButton.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class CustomButton: UIView {
    
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var navigationButton: UIButton!
    
    var tapAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            buttonLabel.font = customFont
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        tapAction?()
    }
}
extension CustomButton{
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = 25.0
        view.layer.masksToBounds = false
        
        // Shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 2
        
        // Border
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        
        addSubview(view)
    }
}
