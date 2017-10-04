//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Luiz Fernando Salvaterra on 03/10/17.
//  Copyright © 2017 Luiz Fernando Salvaterra. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }

}
