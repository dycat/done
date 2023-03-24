//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let alarms: [Alarm] = [Alarm.test]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        self.navigationItem.title = "Alarms"
        view.backgroundColor = .systemBackground
        
        grandAuthorization()
        let content = setUpNotificationContent()
        setupNotificationCenter(content)
        
    }
    
    func setupBarButton() {
        let button = UIBarButtonItem()
        button.title = "Add"
        self.navigationItem.rightBarButtonItem = button
    }
    
    func setupTableView() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    func setupNotificationCenter (_ content: UNNotificationContent) {
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

}


extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print( alarms[indexPath.row].label)
        cell.textLabel?.text = alarms[indexPath.row].label
        return cell
    }
}
