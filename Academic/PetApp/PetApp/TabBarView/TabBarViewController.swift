//
//  TabBarViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers for each tab
        let homeViewController = HomeViewController()
        let petViewController = PetViewController()
        let communityViewController = CommunityViewController()
        let profileViewController = ProfileViewController()
        
        // Set view controllers for the tab bar
        self.setViewControllers([homeViewController, petViewController, communityViewController, profileViewController], animated: false)
        
        // Set tab bar item images
        setTabBarImages()
        
        // Customize tabBar appearance
        customizeTabBarAppearance()
    }
    
    // MARK: - Private Functions
    
    /// Set tab bar item images
    private func setTabBarImages() {
        guard let items = self.tabBar.items else { return }
        
        let images = ["house.fill", "pawprint.fill", "globe", "person.fill"]
        for (index, imageName) in images.enumerated() {
            items[index].image = UIImage(systemName: imageName)
        }
    }
    
    /// Customize tabBar appearance
    private func customizeTabBarAppearance() {
        self.tabBar.barTintColor = UIColor(named: "NormalItem")
        self.tabBar.backgroundColor = UIColor(named: "TabBarColor")
        self.tabBar.tintColor = UIColor(named: "SelectedItem")
        
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.cornerRadius = 30
    }
}

