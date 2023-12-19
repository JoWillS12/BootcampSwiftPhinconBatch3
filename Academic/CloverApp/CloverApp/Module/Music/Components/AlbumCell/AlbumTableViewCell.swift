//
//  AlbumTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import UIKit
import Kingfisher
import AVFoundation

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var playerImage: UIImageView!
    
    var isPlaying: Bool = false
    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let imageURL = URL(string: "https://e-cdns-images.dzcdn.net/images/cover/f7b774a90778e1e7915dd012cda5d7e0/120x120-000000-80-0-0.jpg") {
            albumImage.kf.setImage(with: imageURL)
        }
        playerImage.layer.cornerRadius = 10
        albumImage.layer.borderWidth = 1
        albumImage.layer.masksToBounds = false
        albumImage.layer.cornerRadius = albumImage.frame.size.height / 2
        albumImage.clipsToBounds = true
        buttonPlay.setTitle(" Play", for: .normal)
        buttonPlay.setImage(UIImage(systemName: "play"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func playButton(_ sender: Any) {
        tapAction?()
    }
    
    func startAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0) // Full circle (360 degrees)
        rotationAnimation.duration = 4.0 // Adjust the duration for a slower rotation
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear) // Smooth linear timing
        
        albumImage.layer.add(rotationAnimation, forKey: "continuousRotation")
    }
    
    func stopAnimation() {
        albumImage.layer.removeAnimation(forKey: "continuousRotation")
    }
    
    func playAudioPreview() {
        startAnimation()
        isPlaying = true
    }
    
    func pauseAudioPreview() {
        stopAnimation()
        isPlaying = false
    }
}
