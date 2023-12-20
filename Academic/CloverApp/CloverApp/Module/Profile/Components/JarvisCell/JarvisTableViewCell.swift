//
//  JarvisTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 20/12/23.
//

import UIKit

class JarvisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var personPicture: UIImageView!
    @IBOutlet weak var aiPicture: UIImageView!
    @IBOutlet weak var chatBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCorners(isUserMessage: Bool) {
        if isUserMessage {
            textMessage.textAlignment = .right
            chatBubble.backgroundColor = .green
            aiPicture.isHidden = true
            personPicture.isHidden = false
            chatBubble.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        } else {
            textMessage.textAlignment = .left
            chatBubble.backgroundColor = .gray
            aiPicture.isHidden = false
            personPicture.isHidden = true
            chatBubble.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        // Update chatBubble corners
        chatBubble.layer.cornerRadius = 10
    }
}
