//
//  CheckBox.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class CheckBox: UIView {
    
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    var tapAction: (() -> Void)?
    var forgetAction: (() -> Void)?
    private let disposeBag = DisposeBag()
    var isRectangleFilled = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureButton() {
        updateButtonImage()

        rememberButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleButtonImage()
                self?.tapAction?()
            })
            .disposed(by: disposeBag)
        forgotButton.rx.tap
            .subscribe(onNext: {
                [weak self] in
                self?.forgetAction?()
            })
            .disposed(by: disposeBag)
    }
    
    func toggleButtonImage() {
        isRectangleFilled.toggle()
        updateButtonImage()
    }
    
    func updateButtonImage() {
        let imageName = isRectangleFilled ? "rectangle.fill" : "rectangle"
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .medium)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        rememberButton.setImage(image, for: .normal)

    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        
        rememberButton.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        
        addSubview(view)
    }
}
