//
//  Notification.swift
//  DogApp
//
//  Created by Joseph William Santoso on 15/11/23.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.sendNotification()
        }
    }
    
    func sendNotification() {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Your Notification Title"
        content.body = "Your Notification Body"
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


