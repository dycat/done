//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let alarms: [String] = ["Wake up"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Alarms"
        let button = UIBarButtonItem()
        button.title = "Add"
        
        
        self.navigationItem.rightBarButtonItem = button
        view.backgroundColor = .systemBackground
        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
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


extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = alarms[indexPath.item]
        return cell
    }
}
