//
//  ItemCollectionViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuImage: UIImageView!

    
    var buttonAction: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    
}
