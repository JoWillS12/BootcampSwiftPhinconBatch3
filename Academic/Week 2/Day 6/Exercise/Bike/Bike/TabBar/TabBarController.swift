//
//  TabBarController.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController() 
        let cartViewController = CartViewController()
        let profileViewController = ProfileViewController()
        
        self.setViewControllers([homeViewController, cartViewController, profileViewController], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["bicycle", "cart", "person"]
        for x in 0...2{
            items[x].image = UIImage(systemName: images[x])
        }
        
        self.tabBar.barTintColor = UIColor(red: 36/255, green: 44/255, blue: 59/255, alpha: 1.0)
        self.tabBar.backgroundColor = UIColor(red: 34/255, green: 40/255, blue: 52/255, alpha: 1.0)
        self.tabBar.tintColor = .white
    }
}

