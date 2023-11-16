//
//  SearchProfileViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit

class SearchProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var accountsLabel: UILabel!
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountLine: UIView!
    @IBOutlet weak var placeLine: UIView!
    
    // MARK: - Data
    
    var userData: [Users] = []
    var placeData: [Places] = []
    var filteredData: [Any] = []
    var selectedLabel: UILabel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerTableCell()
        fetchData()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelSearch(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func accountsLabelTapped(_ sender: Any) {
        selectLabel(accountsLabel)
        updateLineColors(accountLine: UIColor(named: "SelectedItem") ?? .white, placeLine: .gray)
        filterData()
    }
    
    @IBAction func placesLabelTapped(_ sender: Any) {
        selectLabel(placesLabel)
        updateLineColors(accountLine: .gray, placeLine: UIColor(named: "SelectedItem") ?? .white)
        filterData()
        
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        selectLabel(accountsLabel)
        searchView.layer.cornerRadius = 20
        searchField.delegate = self
    }
    
    private func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func filterData() {
        guard let searchTerm = searchField.text?.lowercased() else { return }
        
        if searchTerm.isEmpty {
            // Display all data when the search field is empty
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
    
    private func selectLabel(_ label: UILabel) {
        selectedLabel?.textColor = .black
        selectedLabel = label
        selectedLabel?.textColor = UIColor(named: "SelectedItem")
    }
    
    private func updateLineColors(accountLine: UIColor, placeLine: UIColor) {
        self.accountLine.backgroundColor = accountLine
        self.placeLine.backgroundColor = placeLine
    }
    
    // MARK: - Networking
    
    private func fetchData() {
        NetworkManager.shared.makeAPICall(endpoint: .getProfile) { [weak self] (response: Result<[Users], Error>) in
            switch response {
            case .success(let datas):
                self?.userData = datas
                self?.filterData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getPlace) { [weak self] (response: Result<[Places], Error>) in
            switch response {
            case .success(let datas):
                self?.placeData = datas
                self?.filterData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

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
}

// MARK: - UITextFieldDelegate

extension SearchProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Call filterData when the user types in the search field
        filterData()
        return true
    }
}
