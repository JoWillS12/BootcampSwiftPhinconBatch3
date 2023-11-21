//
//  SideViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 17/11/23.
//

import UIKit

protocol SideViewControllerDelegate: AnyObject {
    func didSelectMenuItem(index: Int)
}

class SideViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SideViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "person.fill")!, title: "Agents"),
        SideMenuModel(icon: UIImage(systemName: "medal.fill")!, title: "Tiers"),
        SideMenuModel(icon: UIImage(systemName: "shippingbox.fill")!, title: "Stores"),
        SideMenuModel(icon: UIImage(systemName: "bolt.fill")!, title: "Weaponary"),
        SideMenuModel(icon: UIImage(systemName: "paintbrush.fill")!, title: "Spray"),
        SideMenuModel(icon: UIImage(systemName: "x.circle.fill")!, title: "Log Out")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: SideTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SideTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
}

extension SideViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideTableViewCell", for: indexPath) as! SideTableViewCell
        let menus = menu[indexPath.row]
        cell.menuImage.image = menus.icon
        cell.menuLabel.text = menus.title
        
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectMenuItem(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Specify the height for each row
        return 60.0 // Adjust this value as needed
    }
}
