//
//  CustomButton.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import RxCocoa
import RxSwift

class CustomButton: UIView {
    
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var buttonLabel: UILabel!
    
    var tapAction: (() -> Void)?
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        loadButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        loadButton()
    }
    
    func loadButton(){
        blueButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.tapAction?()
            })
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = 25.0
        view.layer.masksToBounds = false
        
        addSubview(view)
    }
}
