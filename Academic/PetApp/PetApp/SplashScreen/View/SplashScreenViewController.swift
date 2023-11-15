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
    @IBOutlet weak var splashLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var customButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLotti()
        loadButton()
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            splashLabel.font = customFont
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.sendNotification()
        }
    }
}

extension SplashScreenViewController {
    func loadLotti(){
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
    
    func loadButton(){
        customButton.buttonLabel?.text = "Let's Start"
        if let customFont = CodeHelper.loadCustomFont(withName: "Proxima Nova Font", fontSize: 20) {
            self.customButton.buttonLabel?.font = customFont
        }
        customButton.tapAction = {
            let vc = AuthViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            print("Button tapped in SplashScreenViewController!")
        }
    }
    
    func sendNotification() {
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
