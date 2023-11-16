//
//  SplashScreenViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import FloatingPanel

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        floatSetUp()
    }
    
}

extension SplashScreenViewController: FloatingPanelControllerDelegate{
    func floatSetUp() {
        let fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        
        fpc.delegate = self
        appearance.cornerRadius = 20.0
        
        let contentVc = AuthViewController(nibName: "AuthViewController", bundle: nil)
        
        fpc.set(contentViewController: contentVc)
        fpc.surfaceView.appearance = appearance
        fpc.addPanel(toParent: self)
        fpc.show(animated: false) {
            fpc.move(to: .tip, animated: false)
        }
    }
}
