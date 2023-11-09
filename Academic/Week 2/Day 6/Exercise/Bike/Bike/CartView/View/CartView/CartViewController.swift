//
//  CartViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit
import Alamofire

class CartViewController: UIViewController {
    
    
    @IBOutlet weak var customSlider: CustomSlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var couponCode: UITextField!
    @IBOutlet weak var priceTag: UILabel!
    @IBOutlet weak var feeTag: UILabel!
    @IBOutlet weak var discTag: UILabel!
    @IBOutlet weak var totalTag: UILabel!
    
    var selectedProduct: [ProductType] = []
    var totalPrice: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @IBAction func showHistory(_ sender: Any) {
        let vc = HistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let vc = PopUpViewController()
        vc.popupTitle = "Your Code"
        vc.popupStatus = "Successful Added"
        vc.popupDesc = "Discount: 10%"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
        discTag.text = "\(10)%"
    }
    
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource, CustomSliderDelegate, PassingProduct, CartTableViewCellDelegate{
    
    func updatePrice(newPrice: Double) {
        totalPrice = newPrice
        priceTag.text = "$\(totalPrice)"
        totalTag.text = "$\(totalPrice - (totalPrice / 10) + 100.0)"
    }
    
    func setUp() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        customSlider.delegate = self
    }
    
    func passData(data: ProductType) {
        selectedProduct.append(data)
    }
    
    func loadData() {
        if let encodeData = BaseConstant.userDef.data(forKey: "Products") {
            do {
                var product = try JSONDecoder().decode([ProductType].self, from: encodeData)
                print("YOUR DATA is HERE \(product)")
                self.selectedProduct = product
                tableView.reloadData()
                calculateTotalPrice() // Calculate total price after loading the data
            } catch {
                print("Error")
            }
        }
    }
    
    func thumbReachedDestination() {
        if totalTag.text == "$\(0)"{
            self.customSlider.returnInitialLocationAnimated(true)
        }else{
            let vc = PaymentViewController()
            vc.totalAmount = totalTag.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func thumbCurrentPosition(_ position: CGFloat) {
    }
    
    func deletedData(){
        priceTag.text = "$\(0)"
        totalTag.text = "$\(0)"
    }
    
    func calculateTotalPrice() {
        let totalPrice = selectedProduct.reduce(0.0) { $0 + Double($1.price) * Double($1.quantity) }
        priceTag.text = "$\(totalPrice)"
        totalTag.text = "$\(totalPrice + 100.0)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        let product = selectedProduct[indexPath.row]
        cell.selectedProduct = product
        cell.productName.text = product.name
        cell.productPrice.text = "$\(product.price)"
        cell.productImage.image = UIImage(named: product.image)
        cell.productQuantity.text = "\(product.quantity)"
        cell.delegate = self
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Handle the deletion here
            selectedProduct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update the total price and save to UserDefaults after deletion
            deletedData()
            saveProductsToUserDefaults()
        }
    }
    
    func saveProductsToUserDefaults() {
        // Save the updated product list to UserDefaults
        if let encodedData = try? JSONEncoder().encode(selectedProduct) {
            BaseConstant.userDef.set(encodedData, forKey: "Products")
        }
    }
}
