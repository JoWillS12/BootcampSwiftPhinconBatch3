//
//  MethodView.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class MethodView: UIView {
    
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var methodType: UILabel!
    @IBOutlet weak var methodImage: UIImageView!
       
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
    
    @IBAction func selection(_ sender: Any) {
        tapAction?()
    }
    
}

extension MethodView{
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        view.frame = bounds
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 1
        
        addSubview(view)
    }
}
