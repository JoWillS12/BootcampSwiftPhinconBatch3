//
//  Item2CollectionViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class Item2CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBuddies: UIView!
    @IBOutlet weak var buddieName: UILabel!
    @IBOutlet weak var buddieImage: UIImageView!
    @IBOutlet weak var cartButton: UIButton!
    
    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBuddies.layer.cornerRadius = 20
    }
    
    @IBAction func addToCart(_ sender: Any) {
        tapAction?()
    }
}
