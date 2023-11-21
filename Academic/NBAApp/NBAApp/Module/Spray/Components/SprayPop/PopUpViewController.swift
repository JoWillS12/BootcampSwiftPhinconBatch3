//
//  PopUpViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var sprayImage: UIImageView!
    @IBOutlet weak var sprayName: UILabel!
    @IBOutlet weak var viewPop: UIView!
    
    var sprayData: [SprayData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewPop.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSpray()
    }
    
    @IBAction func dismiss(_sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    func fetchSpray() {
        NetworkManager.shared.makeAPICall(endpoint: .getSpray) { [weak self] (response: Result<(Sprays), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload UI with a random spray
                self.sprayData = datas.data
                self.updateUI(with: self.randomSpray())
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func randomSpray() -> SprayData {
        // Choose a random index
        let randomIndex = Int.random(in: 0..<sprayData.count)
        
        // Get the random spray data
        return sprayData[randomIndex]
    }
    
    func updateUI(with spray: SprayData) {
        // Update UI with the provided spray data
        if let imageURL = URL(string: spray.displayIcon) {
            sprayImage.kf.setImage(with: imageURL)
        }
        sprayName.text = spray.displayName
    }
}
