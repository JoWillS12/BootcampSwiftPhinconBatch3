//
//  CircleButtonView.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class CircleButtonView: UIView {
    @IBOutlet weak var buttonClick: UIButton!
    
    var tapAction: (() -> Void)?
    
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
    
    @IBAction func buttonClicked(_ sender: Any) {
        tapAction?()
    }
    
}
extension CircleButtonView{
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.cornerRadius = view.frame.size.width / 2
        view.layer.masksToBounds = true
        
        addSubview(view)
    }
}
