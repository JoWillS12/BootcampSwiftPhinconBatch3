//
//  ProfileViewController.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var logoApp: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: CircleView!
    
    var vm = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        loadData()
        profilePic.galleryButton.isHidden = true
        profilePic.viewToHidden.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoAppTapped))
        logoApp.isUserInteractionEnabled = true
        logoApp.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = SplashScreenViewController()
            self.navigationController?.setViewControllers([vc], animated: false)
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    @IBAction func FAQbutton(_ sender: Any) {
        self.navigationController?.pushViewController(JarvisViewController(), animated: false)
    }
    
    
    @objc func logoAppTapped() {
        let vc = ARGameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: ProfileTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileTableViewCell.self))
    }
    
    func loadData(){
        if let currentUser = Auth.auth().currentUser {
            profileEmail.text = currentUser.email
            
            // Retrieve phone number from UserDefaults
            if let pic = UserDefaults.standard.string(forKey: "userPic") {
                profilePic.profileImage.image = UIImage(named: pic)
            } else {
                // Handle the case where the phone number is not available
                print("Not Available")
            }
            
            vm.fetchUserData(for: currentUser.uid) { result in
                switch result {
                case .success(let user):
                    // Update the UI with the fetched user data
                    self.profileName.text = user.nickname
                    
                    if let profileImageData = UserDefaults.standard.data(forKey: "userPic") {
                        if let profileImage = UIImage(data: profileImageData) {
                            self.profilePic.profileImage.image = profileImage
                        }
                    }
                case .failure(let error):
                    print("Error fetching user data: \(error.localizedDescription)")
                }
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming you have only one section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        let section = ProfileTableViewSection(rawValue: indexPath.row)
        cell.menuName.text = section?.title
        cell.menuImage.image = UIImage(systemName: section?.imageName ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileTableViewSection(rawValue: indexPath.row) {
        case .editProfile:
            let vc = EditViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .notification:
            let vc = NotifViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .download:
            let vc = DownloadSetViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .community:
            let vc = CommunityViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .some(.scan):
            let vc = ScanViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case .game:
            let vc = SKViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .none:
            break
        }
    }
}
