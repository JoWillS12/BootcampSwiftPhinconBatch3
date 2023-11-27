//
//  CartViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customSlide: CustomSlider!
    @IBOutlet weak var vpAmount: UILabel!
    
    var selectedItem: [CartItem]? {
        didSet {
            // Reload the table view when selectedItem is set
            tableView.reloadData()
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(CartViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        selectedItem = fetchSavedItems()
    }
    
    @IBAction func toTopUp(_ sender: Any) {
        self.navigationController?.pushViewController(TopUpViewController(), animated: false)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func registerTableCell(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CartTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CartTableViewCell.self))
        self.tableView.addSubview(self.refreshControl)
    }
    
    func fetchSavedItems() -> [CartItem] {
        return AppSetting.shared.selectedItem
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItem?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Implement the cell configuration based on your design and CartItem properties
        if let data =  selectedItem {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
            let item = data[indexPath.row]
            cell.productName.text = item.itemName
            if let imageURL = URL(string: item.itemImage ?? "") {
                cell.productImage.kf.setImage(with: imageURL)
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Configure delete action for swipe
        let deleteAction = configureDeleteAction(forRowAt: indexPath)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        deleteAction.image = UIImage(systemName: "trash.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = UIColor(named: "PrimaryColor")
        configuration.performsFirstActionWithFullSwipe = false // Optional: Set to true if you want the action to be performed without tapping
        return configuration
    }
    
    private func configureDeleteAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            // Check if there are rows in the section
            guard var selectedItem = self.selectedItem, selectedItem.indices.contains(indexPath.row) else {
                completionHandler(false) // Return false to indicate that the action failed
                return
            }
            
            // Delete the item from the array
            selectedItem.remove(at: indexPath.row)
            
            // Update UserDefaults or any other storage mechanism if needed
            AppSetting.shared.selectedItem = selectedItem
            
            // Assign the updated array back to the property
            self.selectedItem = selectedItem
            
            // Reload the entire table view data
            self.tableView.reloadData()
            
            completionHandler(true)
        }
    }
}
