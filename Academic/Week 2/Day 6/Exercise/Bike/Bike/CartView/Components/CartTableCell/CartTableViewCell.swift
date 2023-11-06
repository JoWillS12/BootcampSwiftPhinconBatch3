//
//  CartTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var productQuantity: UILabel!
    
    var quantity: Int = 1 {
        didSet {
            productQuantity.text = "\(quantity)"
            updateProductPrice()
        }
    }
    var selectedProduct: ProductType? {
        didSet {
            updateProductPrice()
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
        if quantity > 1 {
            quantity -= 1
        }
        
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        quantity += 1
    }
    
}
extension CartTableViewCell{
    func updateProductPrice() {
        if let product = selectedProduct {
            let newPrice = Double(product.price) * Double(quantity)
            productPrice.text = "$\(newPrice)"
        }
    }
}
