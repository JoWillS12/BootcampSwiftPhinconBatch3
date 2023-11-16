//
//  StatsTableViewCell.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 13/11/23.
//

import UIKit
import Lottie

class StatsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var checkMark: LottieAnimationView!
    @IBOutlet weak var circleProgress: CircularProgressView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var statsTitle: UILabel!
    @IBOutlet weak var statsDesc: UILabel!
    
    // MARK: - Properties
    
    var progressNum = 0.0
    var progressColor = UIColor.white
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkMark.isHidden = true
        cellSetup()
        checkTrigger()
    }
    
    // MARK: - Selected State
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5))
    }
    
    // MARK: - Cell Setup and Animation
    
    // Configure the cell's appearance
    func cellSetup() {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor // Change color as needed
        circleProgress.layer.cornerRadius = 16
    }
    
    // Trigger checkmark animation based on progress value
    func checkTrigger() {
        if progressNum == 1.0 {
            checkMark.isHidden = false
            animatedCheck()
        } else {
            checkMark.isHidden = true
        }
    }
    
    // Play the checkmark animation
    func animatedCheck() {
        checkMark.contentMode = .scaleAspectFit
        checkMark.loopMode = .playOnce
        checkMark.animationSpeed = 1
        checkMark.play()
    }
    
    // Update progress and progress color
    func updateProgress(_ progress: CGFloat, progs: UIColor) {
        progressNum = Double(progress)
        progressColor = progs
        circleProgress.progress = progressNum
        circleProgress.progressColor = progressColor
        checkTrigger()
    }
}
