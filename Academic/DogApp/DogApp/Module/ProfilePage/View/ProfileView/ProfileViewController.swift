//
//  ProfileViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import FloatingPanel

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    
    var postData: [CommunityPost] = []
    var profileData: [Profile] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register collection cell, fetch data, update profile, and set up floating panel
        registerCollectionCell()
        fetchData()
        updateProfile()
        floatSetUp()
        
        // Set up tap action for profile view
        profileView.tapAction = { [weak self] in
            self?.navigationController?.pushViewController(EditProfileViewController(), animated: true)
        }
    }
    
    // MARK: - Collection View Setup
    
    /// Register custom collection view cell.
    func registerCollectionCell() {
        collectionView.register(UINib.init(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Profile Functions
    
    /// Update UI with the first profile data from the array.
    func updateProfile() {
        if let profile = profileData.first {
            profileView.nameLabel.text = profile.name
            profileView.addressLabel.text = profile.city
            profileView.profileImage.image = UIImage(named: profile.image)
        }
    }
    
    // MARK: - Data Fetching
    
    /// Fetch user post data and profile data from the network.
    func fetchData() {
        NetworkManager.shared.makeAPICall(endpoint: .myPost) { [weak self] (response: Result<[CommunityPost], Error>) in
            switch response {
            case .success(let datas):
                self?.postData = datas
                self?.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getUser) { [weak self] (response: Result<[Profile], Error>) in
            switch response {
            case .success(let datas):
                self?.profileData = datas
                self?.updateProfile() // Call the function to update the profile information
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Floating Panel Setup
    
    /// Set up the floating panel with a content view controller.
    func floatSetUp() {
        let fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        
        fpc.delegate = self
        appearance.cornerRadius = 20.0
        
        let contentVc = FindFriendViewController(nibName: "FindFriendViewController", bundle: nil)
        
        fpc.set(contentViewController: contentVc)
        fpc.surfaceView.appearance = appearance
        fpc.addPanel(toParent: self)
        fpc.show(animated: false) {
            fpc.move(to: .tip, animated: false)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let data = postData[indexPath.row]
        cell.postImage.image = UIImage(named: data.postImage)
        return cell
    }
    
    // Adjust the size of each cell to display three items per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 5
        let collectionViewSize = collectionView.frame.size.width - padding
        let cellSize = collectionViewSize / 3 - padding
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // Set the minimum spacing between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - FloatingPanelControllerDelegate

extension ProfileViewController: FloatingPanelControllerDelegate {
    // Add any necessary FloatingPanelControllerDelegate methods here
}
