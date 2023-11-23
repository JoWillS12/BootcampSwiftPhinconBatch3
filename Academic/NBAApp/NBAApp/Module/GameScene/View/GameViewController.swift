//
//  GameViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var hkView: SKView!
    @IBOutlet weak var skView: SKView!
    
    private var sidebarMenu: SideViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        
        setUp()
        hkView.isHidden = true
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    @IBAction func hockeyButton(_ sender: Any) {
        hkView.isHidden = false
        skView.isHidden = true
        hkView.isPaused = false
    }
    
    @IBAction func meteorButton(_ sender: Any) {
        hkView.isHidden = true
        skView.isHidden = false
        hkView.isPaused = true
    }
    
    func setUp(){
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Create and present the GameScene
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        hkView.showsFPS = true
        hkView.showsNodeCount = true
        
        // Create and present the GameScene
        let scene2 = CatchGameScene(size: view.bounds.size)
        scene2.scaleMode = .resizeFill
        hkView.presentScene(scene2)
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
