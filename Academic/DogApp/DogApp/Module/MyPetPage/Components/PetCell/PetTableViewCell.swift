//
//  PetTableViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class PetTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petRace: UILabel!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var petBirth: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemSetup()
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Adjust the content view frame with insets
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
    
    // MARK: - Item Setup
    
    /// Configure the appearance of the cell items.
    func itemSetup() {
        // Set corner radius and border properties for the outer view
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        
        // Set corner radius for the pet image
        petImage.layer.cornerRadius = petImage.frame.size.width / 2
    }
}
