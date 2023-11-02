//
//  PopUpViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import Lottie

protocol PopUpDelegate{
    func dismissPopupAndTransition()
}

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var popUpBox: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
  
    var delegate: PopUpDelegate?
    
    var popupTitle: String = ""
    var popupDesc: String = ""
    var popupStatus: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        
        popUpBox.layer.cornerRadius = 10
        titleLabel.text = popupTitle
        descLabel.text = popupDesc
        statusLabel.text = popupStatus
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismissPopupAndTransition()
        }
    }
    
}

extension PopUpViewController {
    func dismissPopupAndTransition() {
        self.dismiss(animated: false, completion: {
            self.delegate?.dismissPopupAndTransition()
        })
        
    }
}


