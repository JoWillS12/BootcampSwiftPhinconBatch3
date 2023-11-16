//
//  CustomButton.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit

class CustomButton: UIView {
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    var tapAction: (() -> Void)?
    
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
        view.frame = bounds
        view.layer.cornerRadius = 25.0
        view.layer.masksToBounds = false
        
        addSubview(view)
    }
}
