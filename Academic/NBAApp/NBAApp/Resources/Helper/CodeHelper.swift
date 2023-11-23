//
//  CodeHelper.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import Foundation
import UIKit

class CodeHelper {
    static func loadNib(for owner: AnyObject) -> UIView {
        let bundle = Bundle(for: type(of: owner))
        let nibName = String(describing: type(of: owner))
        
        guard let nib = bundle.loadNibNamed(nibName, owner: owner, options: nil),
              let view = nib.first as? UIView else {
            return UIView()
        }
        return view
    }
    
    static func loadCustomFont(withName fontName: String, fontSize: CGFloat) -> UIFont? {
        if let customFont = UIFont(name: fontName, size: fontSize) {
            return customFont
        } else {
            print("Font not found. Make sure the font is added to your project and specified in Info.plist.")
            return UIFont.systemFont(ofSize: fontSize) // Use a default font if the custom font can't be loaded
        }
    }
}

class HalfModalPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let height: CGFloat = containerView.bounds.height / 2 // Adjust the height as needed
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    private var initialY: CGFloat = 0
    private var blurView: UIVisualEffectView!
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        // Create and add a blurred background with lower intensity
        let customBlurEffect = UIBlurEffect(style: .dark)
        let customIntensity: CGFloat = 0.8 // Adjust the intensity between 0 and 1
        let customBlurView = UIVisualEffectView(effect: customBlurEffect)
        customBlurView.frame = presentingViewController.view.bounds
        customBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customBlurView.alpha = customIntensity
        presentingViewController.view.addSubview(customBlurView)
        blurView = customBlurView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        blurView.addGestureRecognizer(tapGestureRecognizer)
        presentedViewController.view.layer.cornerRadius = 40 // Adjust the corner radius as needed
        presentedViewController.view.clipsToBounds = true
        
        // Set the initial position to be fully presented (not sliding up)
        presentedViewController.view.frame.origin.y = presentingViewController.view.frame.height - presentedViewController.view.frame.height
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissWithAnimation(true)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Remove the blurred background on dismissal
        blurView.removeFromSuperview()
    }
    
    private func dismissWithAnimation(_ shouldDismiss: Bool) {
        let targetY: CGFloat = shouldDismiss ? presentingViewController.view.frame.height : 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.presentedViewController.view.frame.origin.y = targetY
        }) { _ in
            if shouldDismiss {
                self.presentingViewController.dismiss(animated: false, completion: nil)
            }
        }
    }
}

class NavigationHelper {
    static func navigateToViewController(for index: Int, from navigationController: UINavigationController?) {
        // Instantiate and set the view controller based on the selected index
        let selectedViewController: UIViewController
        
        switch index {
        case 0:
            selectedViewController = MainMenuViewController()
        case 1:
            selectedViewController = AgentViewController()
        case 2:
            selectedViewController = TiersViewController()
        case 3:
            selectedViewController = StoreViewController()
        case 4:
            selectedViewController = WeaponViewController()
        case 5:
            selectedViewController = SprayViewController()
        case 6:
            selectedViewController = GameViewController()
        case 7:
            logout()
            selectedViewController = SplashScreenViewController()
        default:
            selectedViewController = MainMenuViewController()
        }
        
        // Check if the selected view controller is already the current top view controller
        if let topViewController = navigationController?.topViewController, topViewController.isKind(of: type(of: selectedViewController)) {
            // The selected view controller is already on top, no need to navigate again
            return
        }
        
        // Push the selected view controller onto the navigation stack
        navigationController?.pushViewController(selectedViewController, animated: false)
    }
    
    static func handleButtonCondition(for sidebarMenu: SideViewController?, in parentViewController: UIViewController) {
        if let sidebarMenu = sidebarMenu {
            if sidebarMenu.parent == nil {
                // If the sidebar is not added, add it to the parent
                parentViewController.addChild(sidebarMenu)
                parentViewController.view.addSubview(sidebarMenu.view)
                sidebarMenu.didMove(toParent: parentViewController)
            } else {
                // If the sidebar is added, remove it from the parent
                sidebarMenu.willMove(toParent: nil)
                sidebarMenu.view.removeFromSuperview()
                sidebarMenu.removeFromParent()
            }
        }
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
        // Add any other necessary cleanup

        // Optionally, you can present a login screen or perform additional actions
        // For example, presenting AuthViewController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let topViewController = windowScene.windows.first?.rootViewController {
            let splashViewController = SplashScreenViewController()
            topViewController.navigationController?.setViewControllers([splashViewController], animated: false)
        }
    }
}
