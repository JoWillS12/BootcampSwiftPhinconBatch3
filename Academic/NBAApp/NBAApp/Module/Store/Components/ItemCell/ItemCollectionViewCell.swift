//
//  ItemCollectionViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bundleImage: UIImageView!
    @IBOutlet weak var bundleName: UILabel!
    @IBOutlet weak var viewBundle: UIView!
    
    var tapAction: (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBundle.layer.cornerRadius = 20
    }

    @IBAction func addToCart(_ sender: Any) {
        tapAction?()
    }
}
