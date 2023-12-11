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
        
        // Do any additional setup after loading the view.
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
            cell.setName.text = "Wifi Only"
            cell.setImage.image = UIImage(systemName: "wifi")
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QualityTableViewCell", for: indexPath) as! QualityTableViewCell
            cell.qualityName.text = "Video Quality"
            cell.qualityImage.image = UIImage(systemName: "arrowtriangle.right.circle")
            cell.selectionStyle = .none
            cell.optionOneName.text = "360p"
            cell.optionTwoName.text = "480p"
            cell.optionThreeName.text = "720p"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QualityTableViewCell", for: indexPath) as! QualityTableViewCell
            cell.qualityName.text = "Audio Quality"
            cell.qualityImage.image = UIImage(systemName: "doc.badge.gearshape")
            cell.optionOneName.text = "48kHz"
            cell.optionTwoName.text = "96kHz"
            cell.optionThreeName.text = "192kHz"
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell", for: indexPath) as! DownloadTableViewCell
            cell.setName.text = "Delete All Downloads"
            cell.setImage.image = UIImage(systemName: "trash")
            cell.switchButton.isHidden = true
            cell.selectionStyle = .none
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


