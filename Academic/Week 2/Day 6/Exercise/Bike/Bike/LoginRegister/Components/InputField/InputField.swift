//
//  InputField.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit

class InputField: UIView {
    
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var fieldType: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrangeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        arrangeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func arrangeView() {
        guard let view = loadNib() else { return }
        view.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
}
