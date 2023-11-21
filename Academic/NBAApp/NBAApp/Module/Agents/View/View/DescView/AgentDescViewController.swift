//
//  AgentDescViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 20/11/23.
//

import UIKit

class AgentDescViewController: UIViewController {
    
    @IBOutlet weak var agentImage: UIImageView!
    @IBOutlet weak var agentName: UILabel!
    @IBOutlet weak var agentDesc: UILabel!
    @IBOutlet weak var agentDev: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var agentBackground: UIImageView!
    
    var selectedCharacter: ValorantData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let character = selectedCharacter {
            agentName.text = character.displayName
            if let imageURL = URL(string: character.fullPortrait ?? "") {
                agentImage.kf.setImage(with: imageURL)
            }
            if let imageURL = URL(string: character.background ?? "") {
                agentBackground.kf.setImage(with: imageURL)
            }
            agentDesc.text = character.description
            agentDev.text = "Developer : \(character.developerName)"
        }
    }
    
    @IBAction func backToView(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    private func registerTableCell() {
        // Register custom table cell
        tableView.register(UINib(nibName: String(describing: DescTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: DescTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
}
extension AgentDescViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCharacter?.abilities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let abilities = selectedCharacter?.abilities {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescTableViewCell", for: indexPath) as! DescTableViewCell
            let data = abilities[indexPath.row]
            cell.abilityName.text = data.displayName
            cell.abilityDesc.text = data.description
            if let imageURL = URL(string: data.displayIcon ?? "") {
                cell.abilityImage.kf.setImage(with: imageURL)
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
