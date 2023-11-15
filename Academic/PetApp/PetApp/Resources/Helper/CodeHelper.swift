//
//  CodeHelper.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
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
    
    static func loadCustomFont(withName fontName: String, fontSize: CGFloat) -> UIFont? {
        if let customFont = UIFont(name: fontName, size: fontSize) {
            return customFont
        } else {
            print("Font not found. Make sure the font is added to your project and specified in Info.plist.")
            return UIFont.systemFont(ofSize: fontSize) // Use a default font if the custom font can't be loaded
        }
    }
}

extension String {
    func toDate(withFormat format: String = "MMM dd, yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            // Handle the case where the string cannot be converted to a date
            return Date()
        }
    }
}

func calculateAge(from birthdate: String) -> String {
    let birthdateDate = birthdate.toDate()
    let currentDate = Date()

    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year, .month], from: birthdateDate, to: currentDate)

    if let years = ageComponents.year, let months = ageComponents.month {
        if years > 0 {
            return "\(years) years"
        } else {
            return "\(months) months"
        }
    } else {
        return "N/A"
    }
}

