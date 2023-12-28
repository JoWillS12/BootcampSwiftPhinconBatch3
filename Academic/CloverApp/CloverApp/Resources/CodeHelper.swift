//
//  CodeHelper.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import Foundation
import UIKit

class CodeHelper {
    static func loadNib(for owner: AnyObject) -> UIView {
        let bundle = Bundle(for: type(of: owner))
        let nibName = String(describing: type(of: owner))
        
        guard let nib = bundle.loadNibNamed(nibName, owner: owner, options: nil),
              let view = nib.first as? UIView else {
            return UIView()
        }
        return view
    }
    
    static func loadCustomFont(withName fontName: String, fontSize: CGFloat) -> UIFont {
        let customFont = UIFont(name: fontName, size: fontSize)
        return customFont ?? UIFont.systemFont(ofSize: fontSize)
    }
}


