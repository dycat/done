//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Alarms"
        let button = UIBarButtonItem()
        button.title = "Add"
        
        
        self.navigationItem.rightBarButtonItem = button
        view.backgroundColor = .systemBackground
    }


}

