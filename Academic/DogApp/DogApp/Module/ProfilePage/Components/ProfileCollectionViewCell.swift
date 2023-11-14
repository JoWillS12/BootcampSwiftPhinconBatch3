//
//  ProfileCollectionViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemSetup()
    }

}
extension ProfileCollectionViewCell{
    func itemSetup(){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        postImage.layer.cornerRadius = 10
    }
}
