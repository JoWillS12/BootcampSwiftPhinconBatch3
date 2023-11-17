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
        
        presentedViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        presentedViewController.view.layer.cornerRadius = 40 // Adjust the corner radius as needed
        presentedViewController.view.clipsToBounds = true
        
        // Set the initial position to be fully presented (not sliding up)
        presentedViewController.view.frame.origin.y = presentingViewController.view.frame.height - presentedViewController.view.frame.height
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: presentedViewController.view)
        
        switch gestureRecognizer.state {
        case .began:
            initialY = presentedViewController.view.frame.origin.y
        case .changed:
            // Allow only downward pan
            guard translation.y > 0 else {
                return
            }
            
            let newY = max(initialY + translation.y, 0)
            presentedViewController.view.frame.origin.y = newY
        case .ended:
            let shouldDismiss = translation.y > presentedViewController.view.frame.height / 3
            dismissWithAnimation(shouldDismiss)
        default:
            break
        }
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
