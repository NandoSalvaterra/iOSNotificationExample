//
//  ViewController.swift
//  iOSNotificationExample
//
//  Created by Luiz Fernando Salvaterra on 03/10/17.
//  Copyright © 2017 Luiz Fernando Salvaterra. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification Access Granted")
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    @IBAction func buttonTaped(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        }
    }

    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) -> Void) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Title"
        notificationContent.subtitle = "Subtitle"
        notificationContent.body = "This is the body of a notification"
        
        let gifUrl  = Bundle.main.url(forResource: "apple", withExtension: "gif")
        let attachment = try! UNNotificationAttachment(identifier: "appleGif", url: gifUrl!, options: .none)
        notificationContent.attachments = [attachment]
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: "notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

