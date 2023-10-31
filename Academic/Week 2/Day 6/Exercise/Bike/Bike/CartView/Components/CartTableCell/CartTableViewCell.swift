//
//  CartTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var productQuantity: UILabel!
    
    var quantity: Int = 0 {
        didSet {
            productQuantity.text = "\(quantity)"
        }
    }
    var price: Int = 14000{
        didSet{
            productPrice.text = "$\(price)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productView?.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        if quantity > 0 {
            quantity -= 1
            price = 14000 * quantity
        }
        
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        quantity += 1
        price = 14000 * quantity
    }
    
}
