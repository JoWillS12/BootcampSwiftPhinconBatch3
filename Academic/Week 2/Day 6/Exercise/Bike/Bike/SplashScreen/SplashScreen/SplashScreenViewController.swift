//
//  SplashScreenViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        animationView.play()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedLabel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.transitionToLoginPage()
        }
    }
}

extension SplashScreenViewController {
    
    func transitionToLoginPage() {
        let vc = AuthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func animatedLabel(){
        myLabel.center.x = view.center.x
        myLabel.center.x -= view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.myLabel.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
