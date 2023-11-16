//
//  SplashScreenViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit
import Lottie
import UserNotifications

class SplashScreenViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var splashLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var customButton: CustomButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Lottie animation
        setupLottie()
        
        // Setup custom button
        setupButton()
        
        // Apply custom font to labels
        applyCustomFont()
        
        // Schedule notification after 5 seconds
        scheduleNotification()
    }
    
    // MARK: - Private Functions
    
    /// Apply custom font to labels
    private func applyCustomFont() {
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            splashLabel.font = customFont
            customButton.buttonLabel?.font = customFont
        }
    }
    
    /// Setup Lottie animation view
    private func setupLottie() {
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
    
    /// Setup custom button
    private func setupButton() {
        customButton.buttonLabel?.text = "Let's Start"
        
        // Handle button tap
        customButton.tapAction = { [weak self] in
            self?.handleButtonTap()
        }
    }
    
    /// Handle button tap action
    private func handleButtonTap() {
        let vc = AuthViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Button tapped in SplashScreenViewController!")
    }
    
    /// Schedule a local notification after 5 seconds
    private func scheduleNotification() {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Welcome, Pawrent"
        content.body = "Don't forget to walk your dog."
        content.sound = UNNotificationSound.default
        
        // Set the trigger for the notification (e.g., after 5 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create the request
        let request = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error adding notification request: \(error.localizedDescription)")
            } else {
                print("Notification request added successfully")
            }
        }
    }
}
