//
//  CommunityViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import SkeletonView

class CommunityViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var postData: [CommunityPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchView.layer.cornerRadius = 20
        registerTableCell()
        fetchData()
    }
    
    @IBAction private func searchClicked(_sender: Any){
        self.navigationController?.pushViewController(SearchProfileViewController(), animated: true)
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: CommunityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommunityTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
}
extension CommunityViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath) as! CommunityTableViewCell
        let data = postData[indexPath.row]
        cell.userProfile.image = UIImage(named: data.userProfile)
        cell.userName.text = data.userName
        cell.postDate.text = data.postDate
        cell.postImage.image = UIImage(named: data.postImage)
        cell.chatNumber.text = data.chatNumber
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350 // Adjust the spacing height as needed
    }
    
    func fetchData() {
        // Show skeleton view while data is being fetched
        tableView.showAnimatedSkeleton()
        
        NetworkManager.shared.makeAPICall(endpoint: .myPost) { (response: Result<[CommunityPost], Error>) in
            switch response {
            case .success(let datas):
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
