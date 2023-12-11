//
//  PreviewImageViewController.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import UIKit

class PreviewImageViewController: UIViewController {
    
    @IBOutlet weak var previewImage: UIImageView!
    
    var clickedImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadImageFromURL()
    }
    
    func loadImageFromURL() {
        guard let url = URL(string: clickedImage) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.previewImage.image = image
                }
            }
        }.resume()
    }
}
