//
//  ThirdScreenViewController.swift
//  Day4
//
//  Created by Joseph William Santoso on 26/10/23.
//

import UIKit

class ThirdScreenViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if let thirdScreenView = Bundle.main.loadNibNamed("ThirdScreenView", owner: self, options: nil)?.first as? UIView {
//                    view = thirdScreenView
//                }
    }


    @IBAction func chefButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainView", bundle: nil)
        let chefPage = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.present(chefPage, animated: true)
        
    }
    

}
