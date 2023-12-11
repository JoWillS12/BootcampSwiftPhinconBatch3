//
//  CommunityTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userChat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userChat.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
