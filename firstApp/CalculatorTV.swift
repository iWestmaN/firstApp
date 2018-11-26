//
//  CalculatorTV.swift
//  firstApp
//
//  Created by Igor Lishchenko on 11/13/18.
//  Copyright © 2018 Igor Lishchenko. All rights reserved.
//

import UIKit

class CalculatorTV: UITableViewController {
    
    @IBOutlet weak var efficiencyInput: UITextField!
    @IBOutlet weak var distanceInput: UITextField!
    @IBOutlet weak var pricePerLiter: UITextField!
    @IBOutlet weak var totalFuelPrice: UILabel!
    @IBOutlet weak var totalFuel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func fuelCaclulator() -> [String] {
        
        let fuelEfficiency = Double(efficiencyInput.text!)
        let tripDistance = Double(distanceInput.text!)
        let fuelPrice = Double(pricePerLiter.text!)
        var fuel: Double = 0
        var total: Double = 0
        if (tripDistance != nil) && (fuelEfficiency != nil) {
            fuel = (fuelEfficiency! * tripDistance!) / 100
        } else {
            fuel = 0
        }
        if (fuelPrice != nil) {
            total = fuelPrice! * fuel
        } else {
            total = 0
        }
        let result = ["\(fuel.withCommas()) L", "\(total.withCommas()) $"]
        return result
    }
    
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    @IBAction func textFieldEdit(_ sender: UITextField) {
        totalFuel.text = fuelCaclulator()[0]
        totalFuelPrice.text = fuelCaclulator()[1]
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    


}
extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
