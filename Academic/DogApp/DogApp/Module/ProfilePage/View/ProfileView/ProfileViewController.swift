//
//  ProfileViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import FloatingPanel

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var postData: [CommunityPost] = []
    var profileData: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCell()
        fetchData()
        updateProfile()
        floatSetUp()
        profileView.tapAction = {[weak self] in
            self?.navigationController?.pushViewController(EditProfileViewController(), animated: true)
        }
    }
    
    func registerCollectionCell() {
        collectionView.register(UINib.init(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateProfile() {
        // Assuming profileView has name and profileImage properties
        if let profile = profileData.first {
            profileView.nameLabel.text = profile.name
            profileView.addressLabel.text = profile.city
            profileView.profileImage.image = UIImage(named: profile.image)
        }
    }
}
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
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
}

extension ProfileViewController: FloatingPanelControllerDelegate{
    func floatSetUp(){
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
