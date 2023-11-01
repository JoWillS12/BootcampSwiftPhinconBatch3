//
//  AddActivityViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    
    let imagePickerVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func cancelPost(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postActivity(_ sender: Any) {
        
    }
    
    @IBAction func openGallery(_ sender: Any) {
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
}

extension AddActivityViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            previewImage.image = image
        }
        
    }
    
}
