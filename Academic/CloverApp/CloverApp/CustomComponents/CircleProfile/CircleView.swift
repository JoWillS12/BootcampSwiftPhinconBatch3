//
//  CircleView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class CircleView: UIView, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewToHidden: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var galleryButton: UIButton!
    
    let imagePickerVC = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func openGallery(_ sender: Any) {
        print("Button Tapped")
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        if let viewController = self.findViewController() {
            viewController.present(imagePickerVC, animated: true, completion: nil)
        }
    }
    
}
extension CircleView: UIImagePickerControllerDelegate{
    func getBase64StringFromImage() -> String? {
        guard let image = profileImage.image else { return nil }
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        return imageData.base64EncodedString()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.addBorder(width: 2, color: .white, cornerRadius: frame.size.width / 2)
        addSubview(view)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            responder = nextResponder
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
