//
//  DownloadTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {

    @IBOutlet weak var setImage: UIImageView!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWifiData(){
        setName.text = "Wifi Only"
        setImage.image = UIImage(systemName: "wifi")
    }
    
    func setupDeleteData(){
        setName.text = "Delete All Downloads"
        setImage.image = UIImage(systemName: "trash")
        switchButton.isHidden = true
    }
}
