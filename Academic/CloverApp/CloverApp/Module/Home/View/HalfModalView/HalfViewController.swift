//
//  HalfViewController.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import UIKit

class HalfViewController: UIViewController {
    
    @IBOutlet weak var halfTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var mbView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var downloadView: UIView!
    
    var movieNameText: String?
    var movieImagePic: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movieNameText = movieNameText, let movieImagePic = movieImagePic{
            movieImage.image = movieImagePic
            movieName.text = movieNameText
        }
    }
    
    @IBAction func cancelTap(_sender: Any){
        dismiss(animated: true)
    }
    
    @IBAction func downloadTap(_sender: Any){
        let data = true
        NotificationCenter.default.post(
            name: NSNotification.Name("DataNotification"),
            object: nil,
            userInfo: ["data": data]
        )
        self.dismiss(animated: false)
    }
    
    func setUp(){
        cancelView.layer.cornerRadius = 20
        downloadView.layer.cornerRadius = 20
        movieImage.layer.cornerRadius = 20
        mbView.layer.cornerRadius = 20
        
        mbView.layer.borderColor = UIColor.white.cgColor
        mbView.layer.borderWidth = 1
    }
}
