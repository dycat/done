//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Alarms"
        let button = UIBarButtonItem()
        button.title = "Add"
        
        
        self.navigationItem.rightBarButtonItem = button
        view.backgroundColor = .systemBackground
        
        grandAuthorization()
        
        let content = setUpNotificationContent()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 21
        dateComponents.minute = 39
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { err in
            if let err = err {
                print("Error scheduling notification: \(err.localizedDescription)")
            }
        }
    }
    
    func grandAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification Authorized!")
            } else {
                
            }
        }
    }
    
    func setUpNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Wake up!"
        content.body = "It's time to start your day."
        content.sound = UNNotificationSound.default
        return content
    }


}

