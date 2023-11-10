//
//  CouponView.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit

class CouponView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    

}
extension CouponView{
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    func configureView() {
        let view = self.loadNib()
        view.frame = view.bounds
        view.backgroundColor = .red
        self.addSubview(view)
    }
    
}
