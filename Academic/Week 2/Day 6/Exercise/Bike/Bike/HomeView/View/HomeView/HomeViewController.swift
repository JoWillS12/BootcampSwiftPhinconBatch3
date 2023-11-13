//
//  HomeViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: String = "BICYCLE"
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let vc = PAViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView != nil {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: String(describing: BikeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BikeTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: MenuTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MenuTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: ItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, ItemTableViewCellDelegate {
    
    func didSelectProduct(_ product: ProductType) {
        let vc = DetailViewController()
        vc.selectedProduct = product
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BikeTableViewCell", for: indexPath) as? BikeTableViewCell {
                // Configure BikeTableViewCell here
                cell.layer.cornerRadius = 10
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell {
                cell.buttonAction = { [weak self] data in
                    self?.menu = data
                    self?.tableView.reloadData()
                }
                // Set the button action to update the ItemTableViewCell
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell {
                cell.updateData(forMenu: self.menu)
                cell.delegate = self
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    
}


