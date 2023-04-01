//
//  Alarm.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import Foundation

struct Alarm: Codable {
    var label: String
    var time: String
    var isOn: Bool
}


extension Alarm {
    static var test: Alarm = Alarm(label: "Morning", time: "8:00", isOn: true)
    static var AlarmsSavingKey = "alarms"
}

extension Bundle {
    static func saveToUserDefaults<T: Codable>(item: T, key: String) {
        let userdefualts = UserDefaults.standard
        if let savedData = userdefualts.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                var array = try decoder.decode([T].self, from: savedData)
                array.append(item)
                print(array)
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(array)
                userdefualts.set(jsonData, forKey: key)
                
            } catch {
                print("fail to save")
            }
        } else {
            print("Cast to Data failed.")
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
