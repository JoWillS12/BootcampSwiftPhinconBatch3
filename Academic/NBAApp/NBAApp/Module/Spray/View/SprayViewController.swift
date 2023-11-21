//
//  SprayViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class SprayViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var wheelImageView: UIImageView!
    
    private var sidebarMenu: SideViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Customize your wheel image
        wheelImageView.layer.cornerRadius = min(wheelImageView.frame.width, wheelImageView.frame.height) / 2.0
        wheelImageView.clipsToBounds = true
        
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
    }
    
    @IBAction func spinButtonTapped(_sender: UIButton){
        spinWheel()
    }
    
    @IBAction func menuClicked(_sender: Any){
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    
    func spinWheel() {
        // Disable the button during animation
        spinButton.isEnabled = false
        
        // Randomly determine the angle to spin
        let randomAngle = Double.random(in: 5.0...10.0) // Adjust the range as needed
        let rotationAngle = CGFloat(randomAngle * Double.pi)
        
        // Create the rotation animation
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = rotationAngle
        rotationAnimation.duration = 2.0 // Adjust the duration as needed
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        // Set up animation completion block
        CATransaction.setCompletionBlock {
            // Re-enable the button after the animation completes
            self.spinButton.isEnabled = true
            let vc = PopUpViewController()
            self.navigationController?.present(vc, animated: true)
        }
        
        // Apply the rotation animation to the wheel image view
        wheelImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        // Commit the transaction
        CATransaction.commit()
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
