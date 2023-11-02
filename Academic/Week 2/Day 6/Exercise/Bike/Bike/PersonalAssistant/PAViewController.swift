//
//  PAViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 02/11/23.
//

import UIKit
import Lottie

class PAViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var bubbleText: UIImageView!
    @IBOutlet weak var textBubble: UILabel!
    
    let animationDuration: TimeInterval = 6.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
        
        
    }

    @IBAction func dismissBot(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
