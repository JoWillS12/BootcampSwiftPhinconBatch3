//
//  AgentViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 17/11/23.
//

import UIKit
import Kingfisher

class AgentViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var classRole: ClassView!
    
    private var sidebarMenu: SideViewController!
    var datumData: Valorant?
    var playableCharacters: [ValorantData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        
        registerTableCell()
        fetchData()
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    private func registerTableCell() {
        // Register custom table cell
        tableView.register(UINib(nibName: String(describing: AgentCellTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: AgentCellTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
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
    
    private func fetchData() {
        // Fetch community post data
        NetworkManager.shared.makeAPICall(endpoint: .getAgents) { [weak self] (response: Result<(Valorant), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.playableCharacters = datas.data.filter { $0.isPlayableCharacter }
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    
}
extension AgentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playableCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentCellTableViewCell", for: indexPath) as! AgentCellTableViewCell
        
        // Check if there are playable characters
        guard playableCharacters.count > indexPath.row else {
            return cell // Return an empty cell if the index is out of bounds
        }
        
        let data = playableCharacters[indexPath.row]
        
        if let imageURL = URL(string: data.displayIcon) {
            cell.agentImage.kf.setImage(with: imageURL)
        }
        
        if let imageURL = URL(string: data.role?.displayIcon ?? "") {
            cell.roleImage.kf.setImage(with: imageURL)
        }
        
        cell.agentName.text = data.displayName
        
        if let displayName = data.role?.displayName {
            cell.agentRole.text = String("\(displayName)").capitalized
        } else {
            cell.agentRole.text = "Unknown Role"
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationToAgentDesc(index: indexPath.row)
        
    }
    
    func navigationToAgentDesc(index: Int) {
        let selectedCharacter = playableCharacters[index]
        print(selectedCharacter)
        let vc = AgentDescViewController()
        vc.selectedCharacter = selectedCharacter
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AgentViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPlayableCharacters(with: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filterPlayableCharacters(with: "")
        tableView.reloadData()
    }
    
    private func filterPlayableCharacters(with searchText: String) {
        if searchText.isEmpty {
            playableCharacters = datumData?.data.filter { $0.isPlayableCharacter } ?? []
        } else {
            playableCharacters = (datumData?.data ?? []).filter { character in
                let nameMatch = character.displayName.lowercased().contains(searchText.lowercased())
                let roleMatch = String("\(character.role?.displayName)").lowercased().contains(searchText.lowercased())
                return nameMatch || roleMatch
            }
        }
    }
}
