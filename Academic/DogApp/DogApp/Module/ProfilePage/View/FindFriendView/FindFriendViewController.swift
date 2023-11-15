//
//  FindFriendViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit
import Lottie

class FindFriendViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var tableView: UITableView!
    
    var nearData: [Nearby] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableCell()
        fetchData()
        loadLotti()
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: FindTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FindTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func loadLotti(){
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
}

extension FindFriendViewController: UITableViewDelegate, UITableViewDataSource{
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

