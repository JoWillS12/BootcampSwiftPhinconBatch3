//
//  ViewController.swift
//  MultipleCell
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if tableView != nil {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
            tableView.register(UINib(nibName: String(describing: AwayTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AwayTableViewCell.self))
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row == 0 {
            // Create and dequeue a CellTypeA instance for the first row
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
                // Configure CellTypeA here
                return cell
            }
        } else{
            // Create and dequeue a CellTypeB instance for the second row
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AwayTableViewCell", for: indexPath) as? AwayTableViewCell {
                // Configure CellTypeB here
                return cell
            }
        }

        // Return a default UITableViewCell in case of unexpected situations
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the cell at the given indexPath
        return 100 // Adjust this value to the height you want
    }
    
}
