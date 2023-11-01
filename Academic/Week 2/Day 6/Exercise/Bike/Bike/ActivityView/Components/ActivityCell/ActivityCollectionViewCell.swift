//
//  ActivityCollectionViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actImage: UIImageView!
    @IBOutlet weak var likeStatus: UIImageView!
    @IBOutlet weak var actUser: UILabel!
    @IBOutlet weak var actCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeStatus.image = UIImage(named: "heart")
    }
    
    @IBAction func likeButton(_ sender: Any) {
        if likeStatus.image == UIImage(named: "heart"){
            likeStatus.image = UIImage(named: "heartFill")
        }else {
            likeStatus.image = UIImage(named: "heart")
        }
    }
    
}
