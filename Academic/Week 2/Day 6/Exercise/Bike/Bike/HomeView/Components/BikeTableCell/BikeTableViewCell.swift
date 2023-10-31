//
//  BikeTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

class BikeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        mainView.layer.cornerRadius = 10
    }
    
}
