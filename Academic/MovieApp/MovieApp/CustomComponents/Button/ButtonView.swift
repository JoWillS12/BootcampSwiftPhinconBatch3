//
//  ButtonView.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class ButtonView: UIView {
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func buttonClicked(_sender: Any){
        tapAction?()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        addSubview(view)
    }
}
