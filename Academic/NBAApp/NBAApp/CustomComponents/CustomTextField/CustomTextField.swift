//
//  CustomTextField.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit

class CustomTextField: UIView {

    @IBOutlet weak var textTypeImage: UIImageView!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var authType: UITextField!
    
    var tapAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        
        addSubview(view)
    }
}
