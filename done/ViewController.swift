//
//  ViewController.swift
//  done
//
//  Created by yang on 20/3/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var alarms: [Alarm] = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupBarButton()
        self.navigationItem.title = "Alarms"
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alarms = Bundle.readFromUserDefaults(Alarm.self, key: Alarm.AlarmsSavingKey) ?? []
        tableView.reloadData()
    }
    
    func setupBarButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openAddView))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func openAddView() {
        // Create a new instance of the view controller you want to open
        let newAlarmViewController = NewAlarmViewController(mode: .new)

        // Get a reference to the navigation controller
        guard let navigationController = self.navigationController else {
            return
        }

        // Push the new view controller onto the navigation stack
        navigationController.pushViewController(newAlarmViewController, animated: true)
    }
    
    func setupTableView() {
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
        cell.time.text = toReadableTime(timeString: alarms[indexPath.row].time)
        do {
            cell.date = try Date(alarms[indexPath.row].time, strategy: .dateTime)
        } catch {
            
        }
        cell.isOn.isOn = alarms[indexPath.row].isOn
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Bundle.saveArrayToUserDefaults(items: alarms, key: "alarms")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let editAlarmViewController = NewAlarmViewController(mode: .edit, alarm: alarms[indexPath.row])
        navigationController?.pushViewController(editAlarmViewController, animated: true)
    }
    
    func toReadableTime(timeString: String) -> String {
        do {
            let date = try Date(timeString, strategy: .iso8601)

            return date.formatted(date: .omitted, time: .shortened)
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return timeString
    }
}
