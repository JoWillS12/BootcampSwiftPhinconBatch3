//
//  ProfileViewController.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var switchView: ProfileCustomView!
    @IBOutlet weak var switchViewTwo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    
    @IBAction func profileButton(_ sender: Any) {
        switchView.isHidden = false
        switchViewTwo.isHidden = true
        print("button tapped")
    }
    
    @IBAction func bookButton(_ sender: Any) {
        switchView.isHidden = true
        switchViewTwo.isHidden = false
        print("button tapped")
    }
    
}
