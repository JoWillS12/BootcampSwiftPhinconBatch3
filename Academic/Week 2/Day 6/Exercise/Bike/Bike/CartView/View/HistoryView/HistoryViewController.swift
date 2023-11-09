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
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
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
        let history = historyData[indexPath.row]
        cell.priceLabel.text = "\(history.total)"
        return cell
    }
    
    func loadData(){
        let paid = AppSetting.shared.paid
        print("$\(paid)")
        historyData.append(History(total: String(paid)))
        tableView.reloadData()
    }
    
}
