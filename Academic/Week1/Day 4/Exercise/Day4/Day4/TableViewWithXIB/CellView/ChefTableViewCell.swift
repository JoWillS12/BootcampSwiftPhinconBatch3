//
//  ChefTableViewCell.swift
//  Day4
//
//  Created by Joseph William Santoso on 26/10/23.
//

import UIKit

class ChefTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var chefImage: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefLevel: UILabel!
    
    
    static let identifier = "ChefTableViewCell"

    static func nib()-> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
