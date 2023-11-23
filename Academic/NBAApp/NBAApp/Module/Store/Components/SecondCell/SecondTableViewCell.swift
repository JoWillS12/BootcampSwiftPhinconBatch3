//
//  SecondTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bundleView: UIView!
    @IBOutlet weak var buddieView: UIView!
    @IBOutlet weak var bundle: UILabel!
    @IBOutlet weak var buddie: UILabel!
    @IBOutlet weak var bundleButton: UIButton!
    @IBOutlet weak var buddieButton: UIButton!
    
    var bundleAction: (() -> Void)?
    var buddieAction: (() -> Void)?
    let storeViewController = StoreViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
        bundleView.backgroundColor = UIColor(named: "SelectedColor")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func buddieClicked(_ sender: Any) {
        buddieAction?()
        storeViewController.selectedButtonType = "buddie"
        updateLineColors(bundle: UIColor(named: "SecondaryColor") ?? .white, buddie: UIColor(named: "SelectedColor") ?? .white)
    }
    
    @IBAction func bundleClicked(_ sender: Any) {
        bundleAction?()
        storeViewController.selectedButtonType = "bundle"
        updateLineColors(bundle: UIColor(named: "SelectedColor") ?? .white, buddie: UIColor(named: "SecondaryColor") ?? .white)
    }
    
    private func updateLineColors(bundle: UIColor, buddie: UIColor) {
        self.bundleView.backgroundColor = bundle
        self.buddieView.backgroundColor = buddie
    }
    
    func setUp(){
        bundleView.layer.cornerRadius = 20
        buddieView.layer.cornerRadius = 20
        bundleView.layer.borderWidth = 2
        buddieView.layer.borderWidth = 2
        bundleView.layer.borderColor = UIColor.white.cgColor
        buddieView.layer.borderColor = UIColor.white.cgColor
    }
}
