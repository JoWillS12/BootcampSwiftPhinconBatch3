//
//  SplashScreenViewController.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.transitionToLoginPage()
        }
    }
    
    func transitionToLoginPage() {
        let vc = AuthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
