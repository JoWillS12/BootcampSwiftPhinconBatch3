//
//  CartTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainContain: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productView?.layer.cornerRadius = 10
        mainContain.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
}
