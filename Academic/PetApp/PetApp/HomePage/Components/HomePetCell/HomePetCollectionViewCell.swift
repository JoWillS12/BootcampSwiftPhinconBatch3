//
//  HomePetCollectionViewCell.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit

class HomePetCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petKind: UILabel!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var dotOne: UIImageView!
    @IBOutlet weak var dotTwo: UIImageView!
    @IBOutlet weak var dotThree: UIImageView!
    @IBOutlet weak var petStatus: UILabel!
    @IBOutlet weak var view: UIView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupItem()
    }
    
    // MARK: - Item Setup
    
    // Configure the appearance of the cell
    func setupItem() {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        
        petImage.layer.cornerRadius = petImage.frame.size.width / 2
    }
}
