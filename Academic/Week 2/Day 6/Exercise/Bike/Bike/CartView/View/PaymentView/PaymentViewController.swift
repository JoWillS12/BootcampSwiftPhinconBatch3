//
//  PaymentViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    @IBAction func payNow(_ sender: Any) {
        let vc = PopUpViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func cancelPay(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
