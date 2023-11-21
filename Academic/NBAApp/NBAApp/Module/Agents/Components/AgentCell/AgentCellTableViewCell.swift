//
//  AgentCellTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 20/11/23.
//

import UIKit

class AgentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var agentImage: UIImageView!
    @IBOutlet weak var agentName: UILabel!
    @IBOutlet weak var agentRole: UILabel!
    @IBOutlet weak var roleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellSetup() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.white.cgColor // Change color as needed
        agentImage.layer.cornerRadius = agentImage.frame.width / 2
        roleImage.layer.cornerRadius = roleImage.frame.width / 2
    }
}
