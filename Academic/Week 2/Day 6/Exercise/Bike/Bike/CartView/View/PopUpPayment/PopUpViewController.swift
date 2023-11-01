//
//  PopUpViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import Lottie

class PopUpViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var popUpBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        
        popUpBox.layer.cornerRadius = 10
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.transitionToLoginPage()
        }
    }

}

extension PopUpViewController {
    
    func transitionToLoginPage() {
        self.navigationController?.setViewControllers([HomeViewController()], animated: true)
    }
    
}
