//
//  ErrorViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 02/11/23.
//

import UIKit
import Lottie


class ErrorViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
     
        mainView.layer.cornerRadius = 10
    }

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}
