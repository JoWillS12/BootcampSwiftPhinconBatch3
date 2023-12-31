//
//  Extension.swift
//  C
//
//  Created by Joseph William Santoso on 28/12/23.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = maskPath.cgPath
        layer.mask = shapeLayer
    }
    
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
    
    var slashBounds: CGFloat = 2
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, slashBounds: CGFloat = 2) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.slashBounds = slashBounds
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return CGRect.zero }
        
        let height: CGFloat = containerView.bounds.height / slashBounds // Adjust the height as needed
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

class BaseTableViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateHeight() {
        if let tableView = self.superview as? UITableView{
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

extension Sequence{
    /// SwifterSwift: Return a sorted array based on a key path and a compare function.
    ///
    /// - Parameter keyPath: Key path to sort by.
    /// - Parameter compare: Comparison function that will determine the ordering.
    /// - Returns: The sorted array.
    func sorted<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) -> [Element] {
        return sorted { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
    
    /// SwifterSwift: Return a sorted array based on a key path.
    ///
    /// - Parameter keyPath: Key path to sort by. The key path type must be Comparable.
    /// - Returns: The sorted array.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

extension CALayer {
    func addBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        borderWidth = width
        borderColor = color.cgColor
        self.cornerRadius = cornerRadius
        masksToBounds = true
    }
}
