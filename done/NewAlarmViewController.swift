//
//  NewAlarmViewController.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import UIKit

class NewAlarmViewController: UIViewController {
    
    let labelTextField = {
        let textField = UITextField()
        textField.text = "Alarm"
        textField.textColor = .label
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupLabelTextField()
    }
    
    func setupLabelTextField() {
        let magin = view.layoutMarginsGuide
        view.addSubview(labelTextField)
        labelTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelTextField.topAnchor.constraint(equalTo: magin.topAnchor).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
