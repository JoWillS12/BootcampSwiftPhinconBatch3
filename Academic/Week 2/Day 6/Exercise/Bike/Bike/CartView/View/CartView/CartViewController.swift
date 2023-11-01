//
//  CartViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var customSlider: CustomSlider!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        customSlider.delegate = self
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource, CustomSliderDelegate{
    
    func thumbReachedDestination() {
        let vc = PaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func thumbCurrentPosition(_ position: CGFloat) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
}
