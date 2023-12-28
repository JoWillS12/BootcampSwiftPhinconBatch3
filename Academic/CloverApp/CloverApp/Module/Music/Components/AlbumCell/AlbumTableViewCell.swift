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
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var playerImage: UIImageView!
    
    var isPlaying: Bool = false
    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let imageURL = URLstore.albumImageURL {
            albumImage.kf.setImage(with: imageURL)
        }
        playerImage.layer.cornerRadius = 10
        albumImage.layer.borderWidth = 1
        albumImage.layer.masksToBounds = false
        albumImage.layer.cornerRadius = albumImage.frame.size.height / 2
        albumImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    func isPlayMusic() {
        if isPlaying {
            startAnimation()
        } else {
            stopAnimation()
        }
    }
}
