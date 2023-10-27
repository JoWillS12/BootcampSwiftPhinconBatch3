//
//  CustomBookView.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import UIKit

extension UIView{
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
}

class CustomBookView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}

extension CustomBookView{
    
    func configureView() {
        let view = self.loadNib()
        view.frame = view.bounds
        view.backgroundColor = .red
        self.addSubview(view)
    }
    
}
