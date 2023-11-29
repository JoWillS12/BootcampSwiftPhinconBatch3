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
