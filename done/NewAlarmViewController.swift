//
//  NewAlarmViewController.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import UIKit

class NewAlarmViewController: UIViewController {
    
    var isRepeat = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let magin = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: magin.topAnchor).isActive = true
        
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
        
        view.addSubview(isRepeatLabel)
        isRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        isRepeatLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(isRepeatSwitch)
        isRepeatSwitch.leftAnchor.constraint(equalTo: isRepeatLabel.rightAnchor, constant: 40).isActive = true
        isRepeatSwitch.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40).isActive = true
        
        if isRepeat {
            view.addSubview(frequencyLabel)
            frequencyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
            frequencyLabel.topAnchor.constraint(equalTo: isRepeatLabel.bottomAnchor, constant: 40).isActive = true
        }
        
        view.addSubview(cancelButton)
        cancelButton.bottomAnchor.constraint(equalTo: magin.bottomAnchor, constant: -80).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(saveButton)
        saveButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setupLabelTextField() {
        view.addSubview(labelTextField)
        labelTextField.leftAnchor.constraint(equalTo: labelUILabel.rightAnchor, constant: 40).isActive = true
        labelTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
}
