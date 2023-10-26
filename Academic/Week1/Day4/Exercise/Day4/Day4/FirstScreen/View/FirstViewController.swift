//
//  ViewController.swift
//  Day4
//
//  Created by Joseph William Santoso on 26/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var buttonNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
    
    
    @IBAction func nextScreenButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondScreen = storyboard.instantiateViewController(withIdentifier: "SecondScreen") as! SecondTableViewController
        self.navigationController?.pushViewController(secondScreen, animated: false)
    }
}

