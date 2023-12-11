//
//  ContentCollectionViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit
import SkeletonView

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var filmImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filmImage.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.filmImage.hideSkeleton()
        }
    }
}
