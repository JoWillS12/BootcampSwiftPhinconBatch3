//
//  MovieCollectionViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = 16
    }

}
