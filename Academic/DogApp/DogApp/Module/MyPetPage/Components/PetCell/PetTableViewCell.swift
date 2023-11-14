//
//  PetTableViewCell.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class PetTableViewCell: UITableViewCell {

    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petRace: UILabel!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var petBirth: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
    
    func itemSetup(){
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        petImage.layer.cornerRadius = petImage.frame.size.width / 2
    }
}
