//
//  MainViewController.swift
//  Day4
//
//  Created by Joseph William Santoso on 26/10/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var nama: [String] = ["Anthony", "John", "Rick", "Lola"]
    var img: [String] = ["chef1", "chef2", "chef3", "chef4",]
    var level: [String] = ["Level 1", "Level 2", "Level 3", "Level 4",]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChefTableViewCell.nib(), forCellReuseIdentifier: ChefTableViewCell.identifier)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(nama[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nama.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChefTableViewCell.identifier, for: indexPath)as! ChefTableViewCell
        cell.chefName.text = nama[indexPath.row]
        cell.chefLevel.text = level[indexPath.row]
        cell.chefImage.image = UIImage(named: img[indexPath.row])
        return cell
    }

}
