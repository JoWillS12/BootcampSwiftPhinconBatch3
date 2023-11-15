//
//  EndViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customButton: CustomButton!
    
    var selectedPet: MyPet?
    var stats: [Home] = [Home(statsType: "Today's plan", statsPercent: "50% accomplished", statsColor: "TodayColor", statsProg: 0.5),
                         Home(statsType: "Energy available", statsPercent: "50% energy", statsColor: "EnergyColor", statsProg: 0.5),
                         Home(statsType: "Weekly's objectives", statsPercent: "3 walks left", statsColor: "WeekColor", statsProg: 0.8)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
        // Check if there's a selected pet
        if let selectedPet = selectedPet {
            // Update UI based on the selected pet
            petImage.image = UIImage(named: selectedPet.petImage)
            petMessage.text = "It’s done for today, \(selectedPet.petName) thanks you!"
            // Add more updates if needed
        }
        
        registerTableCell()
        customButton.tapAction = {[weak self] in
            let vc = TabBarViewController()
            self?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    func setUp(){
        petImage.layer.cornerRadius = petImage.frame.width / 2
        petImage.layer.borderWidth = 2
        petImage.layer.borderColor = UIColor.white.cgColor
        customButton.buttonLabel.text = "Go back to dashboard"
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: StatsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: StatsTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
}
extension EndViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        let data = stats[indexPath.row]
        cell.statsTitle.text = data.statsType
        cell.statsDesc.text = data.statsPercent
        cell.updateProgress(CGFloat(data.statsProg), progs: UIColor(named: data.statsColor) ?? UIColor.white)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the spacing height as needed
    }
}
