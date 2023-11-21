//
//  BuddiesViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 20/11/23.
//

import UIKit

class BuddiesViewController: UIViewController, SideViewControllerDelegate {
    
    private var sidebarMenu: SideViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    // Implement the SidebarMenuDelegate method
    func didSelectMenuItem(index: Int) {
        // Handle the selected menu item
        print("Selected menu item: \(index)")
        
        NavigationHelper.navigateToViewController(for: index, from: navigationController)
        
        // Dismiss the sidebar menu
        if let sidebarMenu = sidebarMenu {
            sidebarMenu.willMove(toParent: nil)
            sidebarMenu.view.removeFromSuperview()
            sidebarMenu.removeFromParent()
        }
    }
}
