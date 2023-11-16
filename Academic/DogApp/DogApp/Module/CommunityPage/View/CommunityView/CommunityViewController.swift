//
//  CommunityViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import SkeletonView

class CommunityViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    
    var postData: [CommunityPost] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerTableCell()
        fetchData()
    }
    
    // MARK: - Actions
    
    @IBAction private func searchClicked(_sender: Any){
        navigationController?.pushViewController(SearchProfileViewController(), animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // Set up UI elements
        searchView.layer.cornerRadius = 20
    }
    
    private func registerTableCell() {
        // Register custom table cell
        tableView.register(UINib(nibName: String(describing: CommunityTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: CommunityTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Networking
    
    private func fetchData() {
        // Show skeleton view while data is being fetched
        tableView.showAnimatedSkeleton()
        
        // Fetch community post data
        NetworkManager.shared.makeAPICall(endpoint: .myPost) { [weak self] (response: Result<[CommunityPost], Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.postData = datas
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
            
            // Introduce a delay before hiding the skeleton view
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                // Hide skeleton view after a delay
                self.tableView.hideSkeleton()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CommunityTableViewCell.self), for: indexPath) as! CommunityTableViewCell
        let data = postData[indexPath.row]
        
        // Configure cell with community post data
        cell.userProfile.image = UIImage(named: data.userProfile)
        cell.userName.text = data.userName
        cell.postDate.text = data.postDate
        cell.postImage.image = UIImage(named: data.postImage)
        cell.chatNumber.text = data.chatNumber
        
        // Disable cell selection style
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350 // Adjust the spacing height as needed
    }
}
