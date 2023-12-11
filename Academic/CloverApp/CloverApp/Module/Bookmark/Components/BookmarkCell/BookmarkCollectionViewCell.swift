//
//  BookmarkCollectionViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 06/12/23.
//

import UIKit

class BookmarkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = 20
    }

}
