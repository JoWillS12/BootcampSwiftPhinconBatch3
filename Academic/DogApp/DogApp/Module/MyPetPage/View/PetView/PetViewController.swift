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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the spacing height as needed
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Handle the deletion here
            dogData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update the total price and save to UserDefaults after deletion
//            deletedData()
//            saveProductsToUserDefaults()
        }
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
