//
//  MapTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var mapDesc: UILabel!
    @IBOutlet weak var mapName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
