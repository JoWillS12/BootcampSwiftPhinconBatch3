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
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let homeViewController = HomeViewController()
        let mapViewController = MapViewController()
        let cartViewController = CartViewController()
        let activityViewController = ActivityViewController()
        let profileViewController = ProfileViewController()
        
        self.setViewControllers([homeViewController, mapViewController, cartViewController, activityViewController, profileViewController], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["bicycle", "map", "cart", "sparkles.tv", "person"]
        for x in 0...4{
            items[x].image = UIImage(systemName: images[x])
        }
        
        self.tabBar.barTintColor = UIColor(red: 36/255, green: 44/255, blue: 59/255, alpha: 1.0)
        self.tabBar.backgroundColor = UIColor(red: 34/255, green: 40/255, blue: 52/255, alpha: 1.0)
        self.tabBar.tintColor = .white
    }
}

