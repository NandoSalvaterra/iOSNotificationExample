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

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {return}
        
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try! Data(contentsOf: attachment.url)
            imageView.image = UIImage(data: imageData)
        }
    }

}
