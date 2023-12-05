//
//  PopUpViewController.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import UIKit
import UserNotifications

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var percentageTracker: UILabel!
    @IBOutlet weak var bytesTracker: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var viewBackground: UIView!
    
    var shouldCancelDownload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUp()
        simulateDownload()
    }
    
    @IBAction func hideButton(_ sender: Any) {
        dismiss(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.scheduleNotification()
        }
    }
    
    @IBAction func cancelDownload(_ sender: Any) {
        self.shouldCancelDownload = true
        self.dismiss(animated: false)
    }
    
    func setUp(){
        viewBackground.layer.opacity = 0.1
        popView.layer.cornerRadius = 20
        buttonView.layer.cornerRadius = 20
    }
    
    private func simulateDownload() {
        let totalBytes: Int64 = 900 * 1024 * 1024 // 900 MB
        var downloadedBytes: Int64 = 0
        
        // Simulate a download by animating the progress
        let animationDuration: TimeInterval = 5.0 // Adjust the duration as needed
        
        // Animate the progress bar
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear, animations: {
            self.progressView.setProgress(0.0, animated: true)
        }) { (_) in
            // Download completed, perform any necessary actions
            print("Download completed")
            // Dismiss the view only if it's not canceled
            if !self.shouldCancelDownload {
                
            }
        }
        
        // Update labels based on download progress
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.shouldCancelDownload {
                timer.invalidate()
                print("Download canceled")
            } else {
                downloadedBytes += 1024 * 1024 // Simulate downloading 1 MB
                
                let progress = Float(downloadedBytes) / Float(totalBytes)
                self.progressView.setProgress(progress, animated: true)
                
                let percentage = Int(progress * 100)
                self.percentageTracker.text = "\(percentage)%"
                
                let downloadedMB = Float(downloadedBytes) / (1024 * 1024)
                let totalMB = Float(totalBytes) / (1024 * 1024)
                self.bytesTracker.text = String(format: "%.1f / %.1f MB", downloadedMB, totalMB)
                
                if downloadedBytes >= totalBytes {
                    timer.invalidate()
                    self.scheduleNotification()
                }
            }
        }
    }
    
    private func scheduleNotification() {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Hey Clover's Buddies"
        content.body = "Your Download is Success."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
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
