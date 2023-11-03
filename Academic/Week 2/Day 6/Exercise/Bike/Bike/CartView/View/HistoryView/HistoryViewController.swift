//
//  HistoryViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 02/11/23.
//

import UIKit
import Alamofire

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var historyData: [History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
        
        fetchDataFromAPI()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self), for: indexPath) as! HistoryTableViewCell
        let historyItem = historyData[indexPath.row]
        cell.titleLabel.text = historyItem.title
        cell.priceLabel.text = historyItem.tags
        return cell
    }
    
    func fetchDataFromAPI() {
        let apiURL = "http://localhost:3001/api/gethistory"
        NetworkManager.shared.makeAPICall(endpoint: .getHistory, completion: { (response: Result<[History], Error>) in
            switch response {
            case .success(let history):
                self.historyData = history
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        })
    }

}
