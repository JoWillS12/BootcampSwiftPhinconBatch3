//
//  CodeHelper.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
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

extension UIView {
    func roundCornersWithDifferentRadii(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let maskPath = UIBezierPath()
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        maskPath.move(to: CGPoint(x: 0, y: topLeft))
        maskPath.addQuadCurve(to: CGPoint(x: topLeft, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        
        maskPath.addLine(to: CGPoint(x: width - topRight, y: 0))
        maskPath.addQuadCurve(to: CGPoint(x: width, y: topRight), controlPoint: CGPoint(x: width, y: 0))
        
        maskPath.addLine(to: CGPoint(x: width, y: height - bottomRight))
        maskPath.addQuadCurve(to: CGPoint(x: width - bottomRight, y: height), controlPoint: CGPoint(x: width, y: height))
        
        maskPath.addLine(to: CGPoint(x: bottomLeft, y: height))
        maskPath.addQuadCurve(to: CGPoint(x: 0, y: height - bottomLeft), controlPoint: CGPoint(x: 0, y: height))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func setDiagonalLinearGradientWithCornerRadius(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint, cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Set the corner radius
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    func removeBottomBorder() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomBorder.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func applyCommonBackgroundStyle() {
        layer.cornerRadius = 20
        layer.masksToBounds = false
        removeBottomBorder()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for count in 0..<self.visibleCells.count {
            let cell = self.visibleCells[count]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
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

extension UIImage {
    static func fromBase64(_ base64String: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64String) else {
            return nil
        }
        return UIImage(data: data)
    }
}
