//
//  CircleView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class CircleView: UIView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var galleryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func openGallery(_ sender: Any) {
        print("Button Tapped")
    }
}
extension CircleView{
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        addSubview(view)
    }
}
