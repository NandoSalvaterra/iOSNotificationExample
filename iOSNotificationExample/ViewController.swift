//
//  ViewController.swift
//  iOSNotificationExample
//
//  Created by Luiz Fernando Salvaterra on 03/10/17.
//  Copyright © 2017 Luiz Fernando Salvaterra. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification Access Granted")
                UNUserNotificationCenter.current().delegate = self
                self.configureNotification()
            } else {
                print(error?.localizedDescription ?? "Access Denied!")
            }
        }
    }
    
    @IBAction func sendNotificationButtonDidPressed(sender: UIButton) {
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
        
        //Uncomment the line below if you want to see how the Notification Content Extension in action.
        //notificationContent.categoryIdentifier = "notificationCategory"
        
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
                print(error?.localizedDescription ?? "Error adding a notification")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    private func configureNotification() {
       
        let favoriteAction  = UNNotificationAction(identifier: "favoriteAction", title: "Favorite", options: [])
        let dismissAction = UNNotificationAction(identifier: "dismissAction", title: "Dismiss", options: [])
        let category = UNNotificationCategory(identifier: "notificationCategory", actions: [favoriteAction, dismissAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    //MARK: - UNUserNotificationCenterDelegate Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Response receive for \(response.actionIdentifier)")
        completionHandler()
    }
    
}

