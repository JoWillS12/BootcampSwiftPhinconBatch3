//
//  LoginViewController.swift
//  CloverApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp(){
        backView.layer.cornerRadius = 20
        
        backView.layer.masksToBounds = false

        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowRadius = 5
        backView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backView.layer.shadowOpacity = 0.3
        
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.white.cgColor
    }
}
