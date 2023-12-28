//
//  DownloadSetViewController.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class DownloadSetViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func registerTableCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "QualityTableViewCell", bundle: nil), forCellReuseIdentifier: "QualityTableViewCell")
        tableView.register(UINib(nibName: "DownloadTableViewCell", bundle: nil), forCellReuseIdentifier: "DownloadTableViewCell")
    }
}

extension DownloadSetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
            cell.setupWifiData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QualityTableViewCell", for: indexPath) as! QualityTableViewCell
            cell.setupVideoData()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QualityTableViewCell", for: indexPath) as! QualityTableViewCell
            cell.setupAudioData()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
            cell.setupDeleteData()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 3:
            return 60
        case 1, 2:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}


