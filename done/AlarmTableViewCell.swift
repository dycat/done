//
//  AlarmTableViewCell.swift
//  done
//
//  Created by yang on 26/3/2023.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    let alarm: Alarm = Alarm.test
    var date = Date()
    var time = UILabel()
    var label = UILabel()
    var isOn = UISwitch()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        time.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        isOn.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(time)
        time.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: time.rightAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(isOn)
        isOn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        isOn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        isOn.addTarget(self, action: #selector(switchPressed), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func switchPressed(_ switcher: UISwitch) {
        if switcher.isOn {
            print("The switch is On.")
            grandAuthorization()
            let content = setUpNotificationContent()
            setupNotificationCenter(content)
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
        content.title = label.text ?? ""
        content.body = "It's time to start your day."
        content.sound = UNNotificationSound.default
        return content
    }
    
    func setupNotificationCenter (_ content: UNNotificationContent) {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { err in
            if let err = err {
                print("Error scheduling notification: \(err.localizedDescription)")
            }
        }
    }

}
