//
//  StoreViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 22/11/23.
//

import UIKit

class StoreViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var vpAmount: UILabel!
    @IBOutlet weak var vpImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var sidebarMenu: SideViewController!
    var bundleData: [BundleData] = []
    var buddieData: [BuddiesData] = []
    var timer: Timer?
    var selectedButtonType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Instantiate your sidebar menu
        if let imageURL = URL(string: "https://media.valorant-api.com/currencies/85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741/displayicon.png") {
            vpImage.kf.setImage(with: imageURL)
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
        registrationTableCell()
        fetchData()
        selectedButtonType = "bundle"
    }
    
    @IBAction func addVP(_ sender: Any) {
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    @objc func updateData() {
        // Shuffle the array and reload the table view
        bundleData.shuffle()
        tableView.reloadData()
    }
    
    // Implement the SidebarMenuDelegate method
    func didSelectMenuItem(index: Int) {
        // Handle the selected menu item
        print("Selected menu item: \(index)")
        
        NavigationHelper.navigateToViewController(for: index, from: navigationController)
        
        // Dismiss the sidebar menu
        if let sidebarMenu = sidebarMenu {
            sidebarMenu.willMove(toParent: nil)
            sidebarMenu.view.removeFromSuperview()
            sidebarMenu.removeFromParent()
        }
    }
    
    func registrationTableCell(){
        if tableView != nil {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: String(describing: FirstTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FirstTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: SecondTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SecondTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: ThirdTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ThirdTableViewCell.self))
        }
    }
    
    func fetchData(){
        NetworkManager.shared.makeAPICall(endpoint: .getBundles) { [weak self] (response: Result<(Bundles), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.bundleData = datas.data
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getBuddies) { [weak self] (response: Result<(Buddies), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.buddieData = datas.data
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
}
extension StoreViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as? FirstTableViewCell else {
                return UITableViewCell()
            }
            
            if bundleData.indices.contains(section) {
                let datas = bundleData[section]
                
                if let imageURL = URL(string: datas.displayIcon) {
                    cell.promoImage.kf.setImage(with: imageURL)
                }
                cell.selectionStyle = .none
            }
            
            return cell
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as? SecondTableViewCell {
                cell.bundleAction = { [weak self] in
                    self?.selectedButtonType = "bundle"
                    self?.tableView.reloadData() // Reload the table view to update the third cell
                }
                cell.buddieAction = { [weak self] in
                    self?.selectedButtonType = "buddie"
                    self?.tableView.reloadData() // Reload the table view to update the third cell
                }
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as? ThirdTableViewCell {
                cell.selectedButtonType = selectedButtonType
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        switch section{
        case 0:
            return 220
        case 1:
            return 93
        case 2:
            return 360
        default:
            return UITableView.automaticDimension
        }
    }
}
