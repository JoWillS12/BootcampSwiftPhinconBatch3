//
//  LoadingViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 02/11/23.
//

import UIKit
import Lottie

protocol LoadingDelegate{
    func dismissPopupAndTransition()
}

class LoadingViewController: UIViewController {

 
    @IBOutlet weak var animationView: LottieAnimationView!
    
    var delegate: LoadingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.play()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismissPopupAndTransition()
        }
    }

}

extension LoadingViewController {
    func dismissPopupAndTransition() {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.dismissPopupAndTransition()
        }
    }

}
