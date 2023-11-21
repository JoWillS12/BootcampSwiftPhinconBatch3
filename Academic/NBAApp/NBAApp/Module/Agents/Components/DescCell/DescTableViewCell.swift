//
//  DescTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 20/11/23.
//

import UIKit

class DescTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var abilityDesc: UILabel!
    @IBOutlet weak var abilityImage: UIImageView!
    @IBOutlet weak var abilityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 15, right: 5))
    }
}
