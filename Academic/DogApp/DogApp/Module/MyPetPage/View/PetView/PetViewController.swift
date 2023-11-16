//
//  PetViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class PetViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var circleButton: CircleButtonView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data Source
    
    var dogData: [MyPet] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI and configure button tap action
        circleButton.tapAction = { [weak self] in
            self?.navigateToAddPet()
        }
        
        // Register table cell and fetch dog data
        registerTableCell()
        fetchDogData()
    }
    
    // MARK: - Navigation
    
    /// Navigate to the Add Pet screen.
    func navigateToAddPet() {
        let vc = AddPetViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table View Cell Registration
    
    /// Register the custom PetTableViewCell for the table view.
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: PetTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PetTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PetViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as! PetTableViewCell
        let dog = dogData[indexPath.row]
        
        // Configure cell with dog data
        cell.petName.text = dog.petName
        cell.petRace.text = dog.petRace
        cell.petImage.image = UIImage(named: dog.petImage)
        cell.petBirth.text = calculateAge(from: dog.petBirth)
        
        // Set cell appearance and disable selection style
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the spacing height as needed
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Configure delete action for swipe
        let deleteAction = configureDeleteAction(forRowAt: indexPath)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        deleteAction.image = UIImage(systemName: "trash.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = UIColor(named: "PrimaryColor")
        configuration.performsFirstActionWithFullSwipe = false // Optional: Set to true if you want the action to be performed without tapping
        return configuration
    }
    
    // MARK: - Data Fetching
    
    /// Fetch dog data from the server.
    func fetchDogData() {
        NetworkManager.shared.makeAPICall(endpoint: .myPet) { [weak self] (response: Result<[MyPet], Error>) in
            switch response {
            case .success(let dogs):
                self?.dogData = dogs
                self?.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Configure delete action for swipe.
    private func configureDeleteAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            // Handle deletion
            self.dogData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
    }
}
