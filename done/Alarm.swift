//
//  Alarm.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import Foundation

struct Alarm: Codable {
    let id: UUID
    var label: String
    var time: String
    var isOn: Bool
}


extension Alarm {
    static var test: Alarm = Alarm(id: UUID(), label: "Morning", time: "8:00", isOn: true)
    static var AlarmsSavingKey = "alarms"
}

extension Bundle {
    
    static func saveToUserDefaults<T: Codable>(item: T, key: String) {
        let userdefualts = UserDefaults.standard
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        var array: [T] = []
        
        if let savedData = userdefualts.object(forKey: key) as? Data {
            do {
                array = try decoder.decode([T].self, from: savedData)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        
        array.append(item)
            
        do {
            let jsonData = try encoder.encode(array)
            userdefualts.set(jsonData, forKey: key)
            } catch {
                print("fail to save. \(error.localizedDescription)")
        }
        
    }
    
    // TODO: update exist alarm
    static func updateUserDefaults(alarm: Alarm, key: String) {
        let userDefaults = UserDefaults.standard
        var savedAlarms = Bundle.readFromUserDefaults(Alarm.self, key: Alarm.AlarmsSavingKey)
        if let row = savedAlarms?.firstIndex(where: {$0.id == alarm.id}) {
            savedAlarms?[row].isOn = alarm.isOn
            savedAlarms?[row].label = alarm.label
            savedAlarms?[row].time = alarm.time
            
            do { 
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(savedAlarms)
                userDefaults.set(jsonData, forKey: key)
                
            } catch {
                print("\(error.localizedDescription)")
            }
        } else {
            print("Counldn't find the Alarm")
        }
        
    }
    
    static func saveArrayToUserDefaults<T: Codable>(items: [T], key: String) {
        let userdefualts = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(items)
            userdefualts.set(jsonData, forKey: key)
            
        } catch {
            print("fail to save: \(error.localizedDescription)")
        }
        
    }
    
    static func readFromUserDefaults<T: Decodable>(_ type: T.Type, key: String) -> [T]?{
        let userDefualts = UserDefaults.standard
        if let encodedData = userDefualts.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([T].self, from: encodedData)
                return decodedData
            } catch {
                
            }
        }
        return nil
    }
    
}
