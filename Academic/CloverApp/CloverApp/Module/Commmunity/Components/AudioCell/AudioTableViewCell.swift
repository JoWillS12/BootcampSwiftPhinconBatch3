//
//  AudioTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import UIKit
import AVFoundation

class AudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var player: AVPlayer?
    
    var audioURL: URL? {
        didSet {
            print("audioURL set: \(audioURL)")
            configureAudioPlayer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        configureAudioPlayer()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureAudioPlayer() {
        guard let audioURL = audioURL else {
            print("Error: audioURL is nil")
            return
        }
        
        let playerItem = AVPlayerItem(url: audioURL)
        player = AVPlayer(playerItem: playerItem)
        print("Audio player configured successfully for URL: \(audioURL)")
    }
    
    @objc func playButtonTapped() {
        print("Play button tapped")
        if let player = player {
            if player.rate == 0{
                // Player is paused, so play
                player.play()
            } else {
                // Player is playing, so pause
                player.pause()
            }
        }
    }
}


