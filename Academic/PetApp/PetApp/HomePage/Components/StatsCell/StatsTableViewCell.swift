//
//  StatsTableViewCell.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import Lottie

class StatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkMark: LottieAnimationView!
    @IBOutlet weak var circleProgress: CircularProgressView!
    @IBOutlet weak var view: UIView!
    
    var progressNum = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleProgress.progress = progressNum
        checkMark.isHidden = true
        cellSetup()
        checkTrigger()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
}

extension StatsTableViewCell{
    func cellSetup(){
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        circleProgress.layer.cornerRadius = 16
    }
    
    func checkTrigger(){
        if progressNum == 1.0{
            checkMark.isHidden = false
            animatedCheck()
        } else{
            checkMark.isHidden = true
        }
    }
    
    func animatedCheck(){
        checkMark.contentMode = .scaleAspectFit
        checkMark.loopMode = .playOnce
        checkMark.animationSpeed = 1
        checkMark.play()
    }
}
