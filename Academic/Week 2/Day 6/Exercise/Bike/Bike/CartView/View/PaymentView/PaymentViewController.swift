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
        vc.delegate = self
        vc.popupTitle = "Booking Confirmation"
        vc.popupStatus = "Payment Successful"
        vc.popupDesc = "Amount Paid: $12000"
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func cancelPay(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PaymentViewController: PopUpDelegate{
    func dismissPopupAndTransition() {
        self.transitionToHomeViewController()
    }
    
    func transitionToHomeViewController() {
        let vc = TabBarController()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}