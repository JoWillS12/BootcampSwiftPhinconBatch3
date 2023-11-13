//
//  ProfileView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit

class ProfileView: UIView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var tapAction: (() -> Void)?
    
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
    
    @IBAction func editAction(_ sender: Any) {
        tapAction?()
    }
    
}

extension ProfileView{
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        
        addSubview(view)
    }
}
