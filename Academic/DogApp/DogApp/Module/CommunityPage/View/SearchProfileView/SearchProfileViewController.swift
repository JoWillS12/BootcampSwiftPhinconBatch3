//
//  SearchProfileViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit

class SearchProfileViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var accountsLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var userData: [Users] = []
    var placeData: [Places] = []
    var filteredData: [Any] = []
    var selectedLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        fetchData()
        searchView.layer.cornerRadius = 20
        accountsLabelTapped(self)
        searchField.delegate = self
    }
    
    @IBAction func cancelSearch(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func accountsLabelTapped(_ sender: Any) {
        selectLabel(accountsLabel)
        filterData()
    }
    
    @IBAction func placesLabelTapped(_ sender: Any) {
        selectLabel(placesLabel)
        filterData()
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    func filterData() {
        if let searchTerm = searchField.text?.lowercased() {
            if searchTerm.isEmpty {
                // Display all data when search field is empty
                filteredData = selectedLabel == accountsLabel ? userData : placeData
            } else {
                // Apply search filter
                if selectedLabel == accountsLabel {
                    filteredData = userData.filter { $0.name.lowercased().contains(searchTerm) }
                } else if selectedLabel == placesLabel {
                    filteredData = placeData.filter { $0.city.lowercased().contains(searchTerm) || $0.country.lowercased().contains(searchTerm) }
                }
            }
            tableView.reloadData()
        }
    }
    
    func selectLabel(_ label: UILabel) {
        selectedLabel?.textColor = .black
        selectedLabel = label
        selectedLabel?.textColor = UIColor(named: "SelectedItem")
    }
    
}
extension SearchProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchTableViewCell.self), for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        if let user = filteredData[indexPath.row] as? Users {
            cell.itemLabel.text = user.name
        } else if let place = filteredData[indexPath.row] as? Places {
            cell.itemLabel.text = "\(place.city), \(place.country)"
        }
        
        return cell
    }
    
    func fetchData() {
        NetworkManager.shared.makeAPICall(endpoint: .getProfile) { (response: Result<[Users], Error>) in
            switch response {
            case .success(let datas):
                self.userData = datas
                self.filterData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getPlace) { (response: Result<[Places], Error>) in
            switch response {
            case .success(let datas):
                self.placeData = datas
                self.filterData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

extension SearchProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Call filterData when the user types in the search field
        filterData()
        return true
    }
}
