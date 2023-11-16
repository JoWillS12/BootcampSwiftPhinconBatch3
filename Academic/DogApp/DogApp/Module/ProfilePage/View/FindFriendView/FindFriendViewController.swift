//
//  FindFriendViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit
import Lottie

class FindFriendViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    
    var nearData: [Nearby] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register table cell, fetch data, and load Lottie animation
        registerTableCell()
        fetchData()
        loadLotti()
    }
    
    // MARK: - Setup Functions
    
    /// Register custom table cell for the table view.
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: FindTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FindTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    /// Load and configure Lottie animation view.
    func loadLotti() {
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FindFriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindTableViewCell", for: indexPath) as! FindTableViewCell
        let data = nearData[indexPath.row]
        cell.profileImage.image = UIImage(named: data.image)
        cell.profileName.text = data.name
        cell.profileDistance.text = data.distance
        return cell
    }
    
    // MARK: - Data Fetching
    
    /// Fetch nearby data from the network.
    func fetchData() {
        NetworkManager.shared.makeAPICall(endpoint: .getNearby) { [weak self] (response: Result<[Nearby], Error>) in
            switch response {
            case .success(let datas):
                self?.nearData = datas
                self?.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

