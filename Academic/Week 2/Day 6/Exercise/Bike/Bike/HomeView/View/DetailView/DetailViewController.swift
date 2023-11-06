//
//  DetailViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 06/11/23.
//

import UIKit

protocol PassingProduct: AnyObject{
    
    func passData(data: ProductType)
    
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    
    var selectedProduct: ProductType?
    weak var delegate: PassingProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = selectedProduct {
            displayProductDetail(product)
        }
        animatedImage()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func descButton(_ sender: Any) {
    }
    
    @IBAction func addCartButton(_ sender: Any) {
        if let selectedProduct = selectedProduct {
            saveData(selectedProduct)
            print(selectedProduct)
            self.delegate?.passData(data: selectedProduct)
            navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
}
extension DetailViewController{
    func displayProductDetail(_ product: ProductType) {
        productName.text = product.name
        productImage.image = UIImage(named: product.image)
        productPrice.text = "$\(String(product.price))"
    }
    
    func animatedImage(){
        productImage.center.x = view.center.x
        productImage.center.x -= view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.productImage.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func getSavedProduct() -> [ProductType] {
        if let data = UserDefaults.standard.data(forKey: "Products"),
           let savedProducts = try? JSONDecoder().decode([ProductType].self, from: data) {
            print("YOUR DATA is HERE \(savedProducts)")
            return savedProducts
        }
        print("No data!")
        return []
    }
    
    func saveData(_ product: ProductType) -> Bool { // Update the function to return a Bool
        var savedProducts = getSavedProduct()
        savedProducts.append(product)
        if let data = try? JSONEncoder().encode(savedProducts) {
            UserDefaults.standard.set(data, forKey: "Products")
            print("Data Saved \(savedProducts)")
            return true // Return true to indicate a successful save
        } else {
            return false // Return false if there was an issue with the save
        }
    }
    
}
