//
//  AddActivityViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    let imagePickerVC = UIImagePickerController()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        postButton.rx.tap
            .subscribe(onNext: { [weak self] in
                // Implement your postActivity logic here
            })
            .disposed(by: disposeBag)
        
        galleryButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.imagePickerVC.sourceType = .photoLibrary
                self?.imagePickerVC.delegate = self
                self?.present(self!.imagePickerVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        cameraButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.imagePickerVC.sourceType = .camera
                self?.imagePickerVC.delegate = self
                self?.present(self!.imagePickerVC, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}

extension AddActivityViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            previewImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

