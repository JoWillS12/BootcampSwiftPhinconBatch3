//
//  TabBarViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        let petViewController = PetViewController()
        let comViewController = CommunityViewController()
        let profileViewController = ProfileViewController()
        
        self.setViewControllers([homeViewController, petViewController, comViewController, profileViewController], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["house.fill", "pawprint.fill", "globe", "person.fill"]
        for x in 0...3{
            items[x].image = UIImage(systemName: images[x])
        }
        
        // Customize tabBar appearance
        self.tabBar.barTintColor = UIColor(named: "NormalItem")
        self.tabBar.backgroundColor = UIColor(named: "TabBarColor")
        self.tabBar.tintColor = UIColor(named: "SelectedItem")
        
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.cornerRadius = 30
    }
}
