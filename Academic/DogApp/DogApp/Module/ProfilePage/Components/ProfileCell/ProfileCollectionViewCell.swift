//
//  ProfileCollectionViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImage: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemSetup()
    }
    
    // MARK: - Item Setup
    
    /// Configures the appearance of the cell items.
    func itemSetup() {
        // Set border properties for the outer view
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        
        // Set corner radius for the image inside the cell
        postImage.layer.cornerRadius = 10
    }
}
