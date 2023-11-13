//
//  StatsTableViewCell.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleProgress: CircularProgressView!
    
    var progressNum = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleProgress.progress = progressNum
        circleProgress.layer.cornerRadius = circleProgress.bounds.width / 2
        circleProgress.clipsToBounds = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
