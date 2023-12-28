//
//  MovieCollectionViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit
import SkeletonView

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 16
        movieImage.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.movieImage.hideSkeleton()
        }
    }
}
