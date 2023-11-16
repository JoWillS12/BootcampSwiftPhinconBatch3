//
//  CheckBox.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit

class CheckBox: UIView {

    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    var tapAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    
    @IBAction func rememberButton(_ sender: Any) {
        tapAction?()
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        tapAction?()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        
        rememberButton.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        forgotButton.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        
        addSubview(view)
    }
}
