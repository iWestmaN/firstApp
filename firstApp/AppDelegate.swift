//
//  AppDelegate.swift
//  firstApp
//
//  Created by Igor Lishchenko on 10/29/18.
//  Copyright © 2018 Igor Lishchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FuelManager.shared.fetchLogs()
        
        
        return true
    }
 
}

