//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var alarms: [Alarm] = [Alarm.test]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        setupBarButton()
        self.navigationItem.title = "Alarms"
        view.backgroundColor = .systemBackground
        loadAlarms()
    }
    
    func loadAlarms() {
        let userDefualts = UserDefaults.standard
        if let encodedData = userDefualts.object(forKey: "alarms") as? Data {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([Alarm].self, from: encodedData)
                alarms = decodedData
            } catch {
                
            }
        }
    }
    
    func setupBarButton() {
        let button = UIBarButtonItem(title: "Add", style: .plain, target: self, action:  #selector(openAddView))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func openAddView() {
        // Create a new instance of the view controller you want to open
        let newAlarmViewController = NewAlarmViewController()

        // Get a reference to the navigation controller
        guard let navigationController = self.navigationController else {
            return
        }

        // Push the new view controller onto the navigation stack
        navigationController.pushViewController(newAlarmViewController, animated: true)
    }
    
    func setupTableView() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

}


extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlarmTableViewCell
        cell.label.text = alarms[indexPath.row].label
        cell.time.text = alarms[indexPath.row].time
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
