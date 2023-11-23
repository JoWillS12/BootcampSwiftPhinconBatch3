//
//  CustomSlider.swift
//  Bike
//
//  Created by Joseph William Santoso on 31/10/23.
//

import UIKit

protocol CustomSliderDelegate {
    func thumbReachedDestination()
    func thumbCurrentPosition(_ position:CGFloat)
}

class CustomSlider: UIView {

    var delegate: CustomSliderDelegate?
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var sliderPath: UIView!
    @IBOutlet weak var sliderImage: UIView!
    @IBOutlet weak var destination: UIView!
    @IBOutlet weak var sliderImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    var contentView: UIView?
    var initialTopConstraint: CGFloat = 0.0

    var isDestinationReached: Bool {
        get {
            let distanceFromDestination: CGFloat = self.destination.center.x - self.sliderImage.center.x
            return distanceFromDestination < 1
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        arrangeView()
        mainView.backgroundColor = UIColor(red: 34/255, green: 40/255, blue: 52/255, alpha: 1.0)
        sliderPath.layer.cornerRadius = 10
    }

    override func didMoveToWindow() {
        //ensure thumb always start from top
        self.sliderImageLeadingConstraint.constant = 0
        self.initialTopConstraint = self.sliderImageLeadingConstraint.constant;
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        arrangeView()
        contentView?.prepareForInterfaceBuilder()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        arrangeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func panAction() {
        if panGesture.state == .changed {
            slideThumb()
            delegate?.thumbCurrentPosition(self.sliderImage.center.y)
        }
        else if panGesture.state == .ended {
            if isDestinationReached {
                delegate?.thumbReachedDestination()
            }
            else {
                returnInitialLocationAnimated(true)
            }
        }
    }
}

extension CustomSlider{
    
    func arrangeView() {
        guard let view = loadNib() else { return }
        view.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
    }
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    func slideThumb() {
        
        let minX = CGFloat(0)
        let maxX = sliderPath.bounds.size.width - sliderImage.bounds.size.width
        
        var translation =  panGesture.translation(in: sliderPath)
        var draggedDistance = sliderImageLeadingConstraint.constant + translation.x

        // to prevent going up from path bounds
        if draggedDistance < 0 {
            draggedDistance = minX
            translation.x += sliderImageLeadingConstraint.constant - minX
        }
        // to prevent going down from path bounds
        else if draggedDistance > maxX {
            draggedDistance = maxX
            translation.x += sliderImageLeadingConstraint.constant - maxX
        }
        else {
            translation.x = 0
        }
        
        self.sliderImageLeadingConstraint.constant = draggedDistance
        self.panGesture.setTranslation(translation, in: sliderPath)
        
        UIView.animate( withDuration: 0.05, delay: 0, options: .beginFromCurrentState, animations: {
                self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func returnInitialLocationAnimated(_ animated: Bool) {
        sliderImageLeadingConstraint.constant = initialTopConstraint
        
        if (animated) {
            UIView.animate( withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: {
                    self.layoutIfNeeded()
                    self.delegate?.thumbCurrentPosition(self.sliderImage.center.x)
            }, completion: nil)
        }
    }
    
}
