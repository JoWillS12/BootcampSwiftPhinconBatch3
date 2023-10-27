//
//  ProfileCustomViewController.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import UIKit

class ProfileCustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}

extension ProfileCustomView{
    
    private func configureView(){
        let view = self.loadNib()
        view.frame = self.bounds
        view.backgroundColor = .white
        self.addSubview(view)
    }
    
}
