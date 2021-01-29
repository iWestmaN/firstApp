//
//  CalculatorTV.swift
//  firstApp
//
//  Created by Igor Lishchenko on 11/13/18.
//  Copyright © 2018 Igor Lishchenko. All rights reserved.
//

import UIKit

class CalculatorTV: UITableViewController {
    
    @IBOutlet weak var consumptionInput: UITextField!
    @IBOutlet weak var distanceInput: UITextField!
    @IBOutlet weak var pricePerLiter: UITextField!
    @IBOutlet weak var totalFuelPrice: UILabel!
    @IBOutlet weak var totalFuel: UILabel!
    @IBOutlet weak var passangerNumber: UITextField!
    @IBOutlet weak var costPerPerson: UILabel!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keybordTollBar()
        consumptionInput.placeholder = String(UserDefaults.standard.double(forKey: "avarage")) + " L/100km".localized
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.orange
    }
    // MARK: fuelCalculator
    func fuelCaclulator() -> [String] {
        let fuelEfficiency = consumptionInput.text?.doubleValue
        let tripDistance = distanceInput.text?.doubleValue
        let fuelPrice = pricePerLiter.text?.doubleValue
        let numberOfPassangers = Double(passangerNumber.text!)
        var fuel: Double = 0
        var total: Double = 0
        var totalPerPerson: Double = 0
        if (tripDistance != nil) && (fuelEfficiency != nil) {
            fuel = (fuelEfficiency! * tripDistance!) / 100
        } else {
            fuel = 0
        }
        if (fuelPrice != nil) && (numberOfPassangers != nil) {
            total = fuelPrice! * fuel
            totalPerPerson = total / Double(numberOfPassangers!)
        } else {
            total = 0
            totalPerPerson = 0
        }
        let result = ["\(fuel.withCommas() + " " + "L".localized)",
            "\(total.currency)",
            "\(totalPerPerson.currency)" ]
        return result
    }
    // добавление Done & Clear All кнопок
    func keybordTollBar() {
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
            title: "Clear All".localized,
            style: .done,
            target: self,
            action: #selector(clearButton(sender:)))
        
        clearButton.tintColor = .red
        doneButton.tintColor = .orange
        
        toolBar.setItems([clearButton, flexibleSpace, doneButton], animated: false)
        
        consumptionInput.inputAccessoryView = toolBar
        distanceInput.inputAccessoryView = toolBar
        pricePerLiter.inputAccessoryView = toolBar
        passangerNumber.inputAccessoryView = toolBar
    }
    
    func action() {
        totalFuel.text = fuelCaclulator()[0]
        totalFuelPrice.text = fuelCaclulator()[1]
        costPerPerson.text = fuelCaclulator()[2]
        stepperValue.value = passangerNumber.text?.doubleValue ?? 1
        if pricePerLiter.text != "" && distanceInput.text != "" && consumptionInput.text != ""{
            shareButton.isEnabled = true
            //  self.present(activityVC, animated: true, completion: nil)
        } else {
            shareButton.isEnabled = false
            // self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    @objc func clearButton(sender: UIBarButtonItem) {
        consumptionInput.text = ""
        pricePerLiter.text = ""
        distanceInput.text = ""
        totalFuel.text = ""
        totalFuelPrice.text = ""
        passangerNumber.text = ""
        costPerPerson.text = ""
    }
    
    
    @IBAction func textFieldEdit(_ sender: UITextField) {
        action()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        passangerNumber.text = String(Int(stepperValue.value))
        action()
    }
    
    @IBAction func sharePressed(_ sender: UIBarButtonItem) {
        let shareCalculation = """
        \("Fuel cost:".localized) \(totalFuelPrice.text!)
        \("Summ per person:".localized) \(costPerPerson.text!)
        \("Total fuel:".localized) \(totalFuel.text!)
        \("Trip distance:".localized) \(distanceInput.text!) \("km".localized)
        \("Avarage fuel consumption:".localized) \(consumptionInput.text!) \("L/100km".localized)
        \("Number of persons:".localized) \(passangerNumber.text!)
        """
        // making share activity VC to send calculation results
        let activityVC = UIActivityViewController.init(activityItems: [shareCalculation], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)

    }
}
