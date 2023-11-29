//
//  AuthViewController.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var welcomeBox: WelcomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        setUp()
        welcomeBox.actionButton.tapAction = {[weak self] in
            self?.navigationController?.pushViewController(LoginViewController(), animated: false)
        }
    }

    func setUp(){
        backView.setDiagonalLinearGradientWithCornerRadius(colors: [UIColor.white, UIColor.gray, UIColor.black], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0), cornerRadius: 20)
        backView.layer.opacity = 0.9
    }
}
