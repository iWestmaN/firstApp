//
//  FuelManager.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/13/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import Foundation

public class FuelManager {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("array.plist")
    public static let shared = FuelManager()
    public var fuelLogs = [FuelLog]()
    
    public func addLog(_ log: FuelLog) {
        fuelLogs.insert(log, at: 0)
        processLog(log)
        saveLogs()
    }
    
    public func updateLog(_ fuelLog: FuelLog) {
        processLog(fuelLog)
        saveLogs()
    }
    
    public func fetchLogs() {
        var logs = [FuelLog]()
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                logs = try decoder.decode([FuelLog].self, from: data)
                fuelLogs = logs
            } catch {
                print(error)
            }
        }
    }
    
    public func removeAllLogs() {
        fuelLogs.removeAll()
        saveLogs()
    }
    
    public func removeLogAt(_ index: Int) {
        fuelLogs.remove(at: index)
        saveLogs()
    }
    
    func processLog(_ log: FuelLog) {
        
        let index = fuelLogs.firstIndex(of: log)
        
        if index! < (fuelLogs.count - 1) {
            
            let previousLog = fuelLogs[index! + 1]
            
            log.distanceInKiloMeter = log.odometer - previousLog.odometer
            log.litersPerOneHundredKm = 100 / (log.distanceInKiloMeter / log.quantity)
        }
        
        log.pricePerLitre = log.amount / log.quantity
        
    }
    
    func saveLogs() {
        
        let userDefaults = UserDefaults(suiteName: "WestmaN")
        
        if !fuelLogs.isEmpty {
            let log = fuelLogs.first
            
            if let mileage = log?.litersPerOneHundredKm {
                userDefaults?.set(String(describing: mileage.roundTo(places: 2)),
                                  forKey: "FuelLogMilege")
            }
            
            if let price = log?.pricePerLitre {
                userDefaults?.set(String(describing: price.roundTo(places: 2)),
                                  forKey: "FuelLogPrice")
            }
            
            if let distance = log?.distanceInKiloMeter {
                userDefaults?.set(String(describing: distance.roundTo(places: 2)),
                                  forKey: "FuelLogDistance")
            }
        } else {
            
            userDefaults?.set("0", forKey: "FuelLogMilege")
            userDefaults?.set("0", forKey: "FuelLogPrice")
            userDefaults?.set("0", forKey: "FuelLogDistance")
            
        }
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(fuelLogs)
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
        }
        
        
    }
    
}


