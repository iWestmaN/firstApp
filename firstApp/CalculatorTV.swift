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
        
        doneButton()
        attributedPlaceholder()
 
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.orange
        
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
    // добавление Done & Clear All кнопок
    func doneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barStyle = UIBarStyle.black
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.done,
            target: self,
            action: #selector(self.donePressed(_:)))
        
        let clearButton = UIBarButtonItem(
            title: "Clear All",
            style: .done,
            target: self,
            action: #selector(clearButton(sender:)))
        
        clearButton.tintColor = .red
        doneButton.tintColor = .orange
        
        toolBar.setItems([clearButton, flexibleSpace, doneButton], animated: false)
        
        efficiencyInput.inputAccessoryView = toolBar
        distanceInput.inputAccessoryView = toolBar
        pricePerLiter.inputAccessoryView = toolBar
        
    }
    
    func attributedPlaceholder() {
        let placeholderAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray.withAlphaComponent(0.4),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0)]
            as [NSAttributedString.Key : Any]
        
        efficiencyInput.attributedPlaceholder = NSMutableAttributedString(string: "Liters/km", attributes: placeholderAttributes)
        distanceInput.attributedPlaceholder = NSMutableAttributedString(string: "km", attributes: placeholderAttributes)
        pricePerLiter.attributedPlaceholder = NSMutableAttributedString(string: "$/liter", attributes: placeholderAttributes)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        
    }
    @IBAction func textFieldEdit(_ sender: UITextField) {
        totalFuel.text = fuelCaclulator()[0]
        totalFuelPrice.text = fuelCaclulator()[1]
        
    }
    
    @objc func clearButton(sender: UIBarButtonItem) {
        efficiencyInput.text = ""
        pricePerLiter.text = ""
        distanceInput.text = ""
        totalFuel.text = ""
        totalFuelPrice.text = ""
    }
    
    
}




