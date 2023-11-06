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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        customSlider.delegate = self
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
    }
    
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource, CustomSliderDelegate, PassingProduct{
    
    func passData(data: ProductType) {
        selectedProduct.append(data)
    }
    
    func loadData() {
        if let encodeData = UserDefaults.standard.data(forKey: "Products") {
            do {
                var product = try JSONDecoder().decode([ProductType].self, from: encodeData)
                print("YOUR DATA is HERE \(product)")
                self.selectedProduct = product
            } catch {
                print("Error")
            }
        }
        tableView.reloadData()        
    }
    func thumbReachedDestination() {
        let vc = PaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func thumbCurrentPosition(_ position: CGFloat) {
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
        cell.layer.cornerRadius = 10
        return cell
    }
}
