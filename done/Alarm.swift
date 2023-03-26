//
//  Alarm.swift
//  done
//
//  Created by yang on 24/3/2023.
//

import Foundation

struct Alarm {
    var label: String
    var time: String
    var isOn: Bool
}


extension Alarm {
    static var test: Alarm = Alarm(label: "Morning", time: "8:00", isOn: true)
}
