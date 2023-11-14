//
//  CommunityTableViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit
import SkeletonView

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var chatNumber: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var likeStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isSkeletonable = true
        cellSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
    
    @IBAction func likePost(_ sender: Any) {
        if likeStatus.image == UIImage(systemName: "star"){
            likeStatus.image = UIImage(systemName: "star.fill")
            likeStatus.tintColor = UIColor(named: "SelectedItem") ?? .systemBlue
        }else{
            likeStatus.image = UIImage(systemName: "star")
            likeStatus.tintColor = UIColor.gray
        }
    }
    
    func cellSetup(){
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        userProfile.layer.cornerRadius = userProfile.frame.width / 2
    }
}
