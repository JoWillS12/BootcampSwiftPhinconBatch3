//
//  ScanViewController.swift
//  C
//
//  Created by Joseph William Santoso on 13/12/23.
//

import UIKit
import SwiftQRCodeScanner

class ScanViewController: UIViewController {
    
    @IBOutlet weak var qrResult: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func openQr(_ sender: Any) {
        let scanner = QRCodeScannerController()
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
}

extension ScanViewController: QRScannerCodeDelegate {
    func qrScannerDidFail(_ controller: UIViewController, error: QRCodeError) {
        print("error:\(error.localizedDescription)")
    }
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("result:\(result)")
        qrResult.text = "\(result)"
        
        // Check if the scanned result is a valid URL
        if let url = URL(string: result), UIApplication.shared.canOpenURL(url) {
            // Open the URL
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}
