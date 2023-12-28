//
//  NotifTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class NotifTableViewCell: UITableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var settingName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func switchButton(_ sender: Any) {
    }
}
