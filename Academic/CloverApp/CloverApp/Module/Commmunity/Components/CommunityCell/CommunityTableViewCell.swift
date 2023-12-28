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
        userChat.numberOfLines = 0
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(message: ChatMessage) {
        userName.text = message.userName
        userChat.text = message.content.text
    }
}
