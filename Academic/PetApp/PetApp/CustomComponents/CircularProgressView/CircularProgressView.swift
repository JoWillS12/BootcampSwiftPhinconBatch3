//
//  CircularProgressView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit

@IBDesignable
class CircularProgressView: UIView {

    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // Set the progressColor to dark yellow
    @IBInspectable var progressColor: UIColor = UIColor(red: 0.8, green: 0.6, blue: 0.0, alpha: 1.0) {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        clipsToBounds = true
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2

        let startAngle: CGFloat = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * progress

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        progressColor.setStroke()
        path.lineWidth = 10
        path.stroke()
    }
}


