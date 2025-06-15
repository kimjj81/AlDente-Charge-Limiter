//
//  PersistanceManager.swift
//  AlDente
//
//  Created by David Wernhart on 07.02.21.
//  Copyright © 2021 David Wernhart. All rights reserved.
//

import Foundation

class PersistanceManager{
    static let instance = PersistanceManager()

    public var launchOnLogin: Bool?
    public var chargeVal: Int?
    public var oldKey: Bool = false
    public var lastCalibration: Date?
    
    public func load(){
        launchOnLogin = UserDefaults.standard.bool(forKey: "launchOnLogin")
        oldKey = UserDefaults.standard.bool(forKey: "oldKey")
        chargeVal = UserDefaults.standard.integer(forKey: "chargeVal")
        if let time = UserDefaults.standard.object(forKey: "lastCalibration") as? Double {
            lastCalibration = Date(timeIntervalSince1970: time)
        }
    }

    public func save(){
        UserDefaults.standard.set(launchOnLogin, forKey: "launchOnLogin")
        UserDefaults.standard.set(chargeVal, forKey: "chargeVal")
        UserDefaults.standard.set(oldKey, forKey: "oldKey")
        if let date = lastCalibration {
            UserDefaults.standard.set(date.timeIntervalSince1970, forKey: "lastCalibration")
        }
    }

    public func calibrationDue(intervalDays: Int = 30) -> Bool{
        guard let last = lastCalibration else {return true}
        return Date().timeIntervalSince(last) >= Double(intervalDays*24*60*60)
    }
}
