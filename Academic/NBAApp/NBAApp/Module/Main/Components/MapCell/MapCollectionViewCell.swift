//
//  MapCollectionViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mapImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapImage.layer.cornerRadius = 10
    }

}
