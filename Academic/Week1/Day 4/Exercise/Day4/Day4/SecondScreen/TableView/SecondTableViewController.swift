//
//  SecondTableViewController.swift
//  Day4
//
//  Created by Joseph William Santoso on 26/10/23.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodContent: UIView!
}

class SecondTableViewController: UITableViewController {
    
    var indexSelected: Int?
    var foods = ["Fried Chicken", "Pizza", "Burger", "Noodle"]
    var images = ["chicken", "pizza", "burger", "noodle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.black
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTableViewCell
        let food = foods[indexPath.row]
        let img = images[indexPath.row]
        cell.foodName.text = food
        cell.foodImage.image = UIImage(named:img)
        cell.foodContent.backgroundColor = UIColor.black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        let nextPage = ThirdScreenViewController()
        self.navigationController?.pushViewController(nextPage, animated: false)
        
    }
}
    
