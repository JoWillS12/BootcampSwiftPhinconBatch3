//
//  WelcomeView.swift
//  MovieApp
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class WelcomeView: UIView {
    
    @IBOutlet weak var actionButton: ButtonView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var messages = [
        "Explore a vast collection of films across genres, discover new releases, and tailor your watchlist to your cinematic preferences.",
        "Enjoy an immersive movie experience with personalized recommendations just for you. Happy watching!"
    ]
    
    var timer: Timer?
    var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        startTimer()
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        actionButton.roundCornersWithDifferentRadii(topLeft: 60, topRight: 10, bottomLeft: 10, bottomRight: 60)
        view.layer.cornerRadius = 20
        addSubview(view)
        
        actionButton.buttonLabel.text = "Get Started"
        // Set the initial message
        messageLabel.text = messages.first
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateMessage), userInfo: nil, repeats: true)
    }
    
    @objc func updateMessage() {
        currentIndex = (currentIndex + 1) % messages.count
        messageLabel.text = messages[currentIndex]
    }
    
    deinit {
        timer?.invalidate()
    }
}


