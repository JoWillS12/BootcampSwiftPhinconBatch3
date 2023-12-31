//
//  TabBarViewController.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers for each tab
        let homeViewController = HomeViewController()
        let musicViewController = MusicViewController()
        let bookmarkViewController = BookmarkViewController()
        let downloadViewController = DownloadViewController()
        let profileViewController = ProfileViewController()
        // Set view controllers for the tab bar
        self.setViewControllers([homeViewController, musicViewController, bookmarkViewController, downloadViewController, profileViewController], animated: false)
        
        // Set tab bar item images
        setTabBarImages()
        
        // Customize tabBar appearance
        customizeTabBarAppearance()
    }
    
    // MARK: - Private Functions
    
    /// Set tab bar item images
    private func setTabBarImages() {
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "music.note", "bookmark", "square.and.arrow.down", "person"]
        for (index, imageName) in images.enumerated() {
            items[index].image = UIImage(systemName: imageName)
        }
    }
    
    /// Customize tabBar appearance
    private func customizeTabBarAppearance() {
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.backgroundColor = UIColor(named: "Background")
        self.tabBar.tintColor = UIColor.white
        
        self.tabBar.clipsToBounds = true
    }
}
