//
//  MusicTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var musicArtist: UILabel!
    @IBOutlet weak var musicName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        musicName.numberOfLines = 0
    }

}
