//
//  PetViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class PetViewController: UIViewController {
    
    @IBOutlet weak var circleButton: CircleButtonView!
    @IBOutlet weak var tableView: UITableView!
    
    var dogData: [MyPet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        circleButton.tapAction = { [weak self] in
            self?.navigateToAddPet()
        }
        registerTableCell()
        fetchDogData()
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: PetTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PetTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func navigateToAddPet(){
        let vc = AddPetViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension PetViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as! PetTableViewCell
        let dog = dogData[indexPath.row]
        cell.petName.text = dog.petName
        cell.petRace.text = dog.petRace
        cell.petImage.image = UIImage(named: dog.petImage)
        cell.petBirth.text = calculateAge(from: dog.petBirth)
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.1
//        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
//        cell.layer.shadowRadius = 2
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the spacing height as needed
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            // Handle the deletion here
            self.dogData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update the total price and save to UserDefaults after deletion
            // deletedData()
            // saveProductsToUserDefaults()
            
            // Call the completion handler to indicate that the action was performed
            completionHandler(true)
        }
        
        // Customize the appearance of the delete button
        deleteAction.image = UIImage(systemName: "trash.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = UIColor(named: "PrimaryColor")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // Optional: Set to true if you want the action to be performed without tapping
        
        return configuration
    }
    
    
    func fetchDogData() {
        NetworkManager.shared.makeAPICall(endpoint: .myPet) { (response: Result<[MyPet], Error>) in
            switch response {
            case .success(let dogs):
                self.dogData = dogs
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}
