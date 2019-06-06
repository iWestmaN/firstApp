//
//  ViewController.swift
//  LineChartExample
//
//  Created by Osian on 13/07/2017.
//  Copyright © 2017 Osian. All rights reserved.
//

import UIKit
import Charts // You need this line to be able to use Charts Library
class ViewController: UIViewController {
    
    @IBOutlet weak var txtTextBox: UITextField!
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var textView: UITextView!
//     public var fuelLog: FuelLog?
    
    public var fuelLog: FuelLog?
    public var fuelLogs = [FuelLog]()
    
    var numbers : [Double] = [] //This is where we are going to store all the numbers. This can be a set of numbers that come from a Realm database, Core data, External API's or where ever else
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //   setLogView(FuelManager.shared.fuelLogs[1])
       var i = FuelManager.shared.fuelLogs.count
       i -= 1
       // print(i)
        var arr = [CGFloat]()
        for b in 0..<i {
        let a = FuelManager.shared.fuelLogs[b].litersPerOneHundredKm
        arr.append(a)
            print(arr)
        }
        
}
  
    func setLogView(_ fuelLog: FuelLog) {
        
        textView?.text = String(describing: fuelLog.litersPerOneHundredKm)
        
    }

}
