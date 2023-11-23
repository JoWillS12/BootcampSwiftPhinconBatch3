//
//  FirstTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var promoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        promoImage.layer.cornerRadius = 10
        promoImage.layer.borderColor = UIColor.white.cgColor
        promoImage.layer.borderWidth = 1
    }
    
}
