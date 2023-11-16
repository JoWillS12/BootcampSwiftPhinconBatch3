//
//  CommunityTableViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit
import SkeletonView

class CommunityTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var chatNumber: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var likeStatus: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSkeletonView()
        cellSetup()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
    
    // MARK: - Actions
    
    @IBAction func likePost(_ sender: Any) {
        toggleLikeStatus()

    }
    
    // MARK: - Cell Setup
    
    func cellSetup() {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        userProfile.layer.cornerRadius = userProfile.frame.width / 2
    }
    
    // MARK: - Private Methods
    
    private func toggleLikeStatus() {
        if likeStatus.image == UIImage(systemName: "star") {
            likeStatus.image = UIImage(systemName: "star.fill")
            likeStatus.tintColor = UIColor(named: "SelectedItem") ?? .systemBlue
        } else {
            likeStatus.image = UIImage(systemName: "star")
            likeStatus.tintColor = UIColor.gray
        }
    }
    
    private func setupSkeletonView() {
        isSkeletonable = true
    }
}
