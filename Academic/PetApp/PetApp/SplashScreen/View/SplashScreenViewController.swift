//
//  SplashScreenViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var splashLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var customButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLotti()
        loadButton()
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            splashLabel.font = customFont
        }
    }
}

extension SplashScreenViewController {
    func loadLotti(){
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
    
    func loadButton(){
        customButton.buttonLabel?.text = "Let's Start"
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            self.customButton.buttonLabel?.font = customFont
        }
        customButton.tapAction = {
            let vc = AuthViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Button tapped in SplashScreenViewController!")
        }
    }
}
