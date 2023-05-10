//
//  NewAlarmViewController.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import UIKit
import UserNotifications

class NewAlarmViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var viewControllerTitle = ""
    var label = "Alarm"
    var date = Date()
    var mode: AlarmViewMode = .new
    var alarm: Alarm = Alarm.test
    
    enum AlarmViewMode {
        case new, edit
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    @objc func switchOnOff() {
        frequencyLabel.isHidden.toggle()
        frequencyPicker.isHidden.toggle()
    }
    
    @objc func updateDate(sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc func updateLabel(sender: UITextField) {
        label = sender.text ?? ""
    }
    
    func setupLabelTextField() {
        view.addSubview(labelTextField)
        labelTextField.leftAnchor.constraint(equalTo: labelUILabel.rightAnchor, constant: 40).isActive = true
        labelTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        labelTextField.delegate = self
        labelTextField.addTarget(self, action: #selector(updateLabel), for: .valueChanged)
        labelTextField.text = alarm.label
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        label = textField.text ?? "Alarm"
        return true
    }
    
    let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Alarm"
        return label
    }()
    
    let labelUILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        return label
    }()
    
    let labelTextField = {
        let textField = UITextField()
        textField.text = "Alarm"
        textField.textColor = .label
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let timeLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        return label
    }()
    
    let datePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let isRepeatLabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repeat"
       return label
    }()

    let isRepeatSwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
       return switcher
    }()
    
    let frequencyLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "Frequency"
        return label
    }()
    
    let saveButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let cancelButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        return button
    }()
    
    let frequencyPicker = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    }()
    
    // TODO: Persistence
    @objc func save() {
        // TODO: Init userdefaults with suitname
        // UserDefaults(suiteName: "")
        alarm.isOn = true
        alarm.label = label
        alarm.time = date.ISO8601Format()
        switch mode {
        case .new:
            Bundle.saveToUserDefaults(item: alarm, key: Alarm.AlarmsSavingKey)
        case .edit:
            Bundle.updateUserDefaults(alarm: alarm, key: Alarm.AlarmsSavingKey)
        }
        setNotification()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    convenience init(mode: AlarmViewMode, alarm: Alarm = Alarm.test) {
        self.init()
        
        self.mode = mode
        switch mode {
        case .edit:
            self.viewControllerTitle = "Edit Alarm"
            self.alarm = alarm
        case .new:
            self.viewControllerTitle = "New Alarm"
            self.alarm = alarm
        }
        
    }
    
}

// MARK: Setup UI
extension NewAlarmViewController {
    func setupUI() {
        let magin = view.layoutMarginsGuide
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: magin.topAnchor).isActive = true
        titleLabel.text = viewControllerTitle
        
        view.addSubview(labelUILabel)
        labelUILabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        labelUILabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true

        setupLabelTextField()
        
        view.addSubview(timeLabel)
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        timeLabel.topAnchor.constraint(equalTo: labelUILabel.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(datePicker)
        datePicker.leftAnchor.constraint(equalTo: timeLabel.rightAnchor, constant: 40).isActive = true
        datePicker.topAnchor.constraint(equalTo: labelUILabel.bottomAnchor, constant: 40).isActive = true
        datePicker.addTarget(self, action: #selector(updateDate), for: .valueChanged)
        do {
            datePicker.date = try Date(alarm.time, strategy: .dateTime)
        } catch {
            
        }
        
        view.addSubview(isRepeatLabel)
        isRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        isRepeatLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(isRepeatSwitch)
        isRepeatSwitch.leftAnchor.constraint(equalTo: isRepeatLabel.rightAnchor, constant: 40).isActive = true
        isRepeatSwitch.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(frequencyLabel)
        frequencyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        frequencyLabel.topAnchor.constraint(equalTo: isRepeatLabel.bottomAnchor, constant: 40).isActive = true
        
        isRepeatSwitch.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
        
        view.addSubview(frequencyPicker)
        frequencyPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        frequencyPicker.topAnchor.constraint(equalTo: isRepeatSwitch.bottomAnchor, constant: 40).isActive = true
        
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        
        view.addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: magin.bottomAnchor, constant: -80).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        view.addSubview(saveButton)
        saveButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension NewAlarmViewController {
    // MARK: Setup Notification
    func setNotification() {
        grandAuthorization()
        let content = setUpNotificationContent()
        setupNotificationCenter(content)
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
        content.title = label
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


extension NewAlarmViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        labelTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        labelTextField.resignFirstResponder()
        return true
    
    }
    
}

extension NewAlarmViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let week = ["Mon", "Feb", "Wed", "Thu", "Fri", "Sat", "Sun"]
        return week[row]
    }
}
