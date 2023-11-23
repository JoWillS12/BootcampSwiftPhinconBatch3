//
//  CustomTextField.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class CustomTextField: UIView {
    
    @IBOutlet weak var textTypeImage: UIImageView!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var authType: UITextField!
    
    var tapAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(eyeImageTapped))
        eyeImage.isUserInteractionEnabled = true
        eyeImage.addGestureRecognizer(tapGesture)
        
        authType.becomeFirstResponder()
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
    
    @objc func eyeImageTapped() {
        // Handle the tap action when the eye image is clicked
        tapAction?()
    }
}
