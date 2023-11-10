//
//  PaymentViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import Firebase

class PaymentViewController: UIViewController {
    
    var totalAmount: String?
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var couponView: CouponView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        fetchUserData()
        couponView.totalLabel.text = "\(totalAmount ?? String())"
    }
    
    @IBAction func payNow(_ sender: Any) {
        if let total = totalAmount {
            let vc = PopUpViewController()
            vc.delegate = self
            vc.popupTitle = "Booking Confirmation"
            vc.popupStatus = "Payment Successful"
            vc.popupDesc = "Amount Paid: \(total)" // Use the totalAmount property
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            saveData()
            BaseConstant.userDef.removeObject(forKey: "Products")
            self.navigationController?.present(vc, animated: true)
        }
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
    
    func saveData(){
        if let totalValue = Double((totalAmount?.replacingOccurrences(of: "$", with: ""))!) {
            AppSetting.shared.paid = totalValue
            print(totalValue)
        }
    }
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Reference to the user's data in the Firebase Realtime Database
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            if let userData = snapshot.value as? [String: Any] {
                if let address = userData["address"] as? String {
                    self.labelAddress.text = "\(address)"
                }
                if let cardNumber = userData["card"] as? String {
                    self.couponView.cardLabel.text = "\(cardNumber)"
                }
                if let userName = userData["username"] as? String{
                    self.couponView.nameLabel.text = "\(userName)"
                }
            }
        })
    }
}
