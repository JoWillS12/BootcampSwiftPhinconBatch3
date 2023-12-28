//
//  FilterViewController.swift
//  C
//
//  Created by Joseph William Santoso on 22/12/23.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var azView: UIView!
    @IBOutlet weak var yearView: UIView!
    
    var sortAz: (()->Void)?
    var sortYear: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func azSort(_ sender: Any) {
        sortAz?()
    }
    
    @IBAction func yearSort(_ sender: Any) {
        sortYear?()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setUp(){
        azView.layer.cornerRadius = 16
        yearView.layer.cornerRadius = 16
    }
}
