//
//  AddLogTableViewController.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/13/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import UIKit

class AddLogTableViewController: UITableViewController {
    
    @IBOutlet weak var odometerTextField: UITextField?
    @IBOutlet weak var quantityTextField: UITextField?
    @IBOutlet weak var amountTextField: UITextField?
    @IBOutlet weak var actionButton: UIButton?
    
    public var fuelLog: FuelLog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.darkGray
        
   //     navigationController!.navigationItem.backBarButtonItem?.tintColor = .orange
        
        actionButton?.setTitle("Add".localized, for: .normal)
        
        if self.fuelLog != nil {
            setLogView(self.fuelLog!)
            actionButton?.setTitle("Update".localized, for: .normal)
        } else if !FuelManager.shared.fuelLogs.isEmpty {
            setLogView(FuelManager.shared.fuelLogs.first!)
        }
        odometerTextField?.becomeFirstResponder()
    }
    
    
    func setLogView(_ fuelLog: FuelLog) {
        odometerTextField?.placeholder = String(describing: fuelLog.odometer)
        quantityTextField?.placeholder = String(describing: fuelLog.quantity)
        amountTextField?.placeholder = String(describing: fuelLog.amount)
    }
    
//    func attributedPlaceholder() {
//        let placeholderAttributes = [
//            NSAttributedString.Key.foregroundColor : UIColor.orange.withAlphaComponent(0.4),
//            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0)]
//            as [NSAttributedString.Key : Any]
//
//        odometerTextField?.attributedPlaceholder = NSMutableAttributedString(string: NSLocalizedString("Odometr", comment: "Odometr"), attributes: placeholderAttributes)
//        quantityTextField?.attributedPlaceholder = NSMutableAttributedString(string: NSLocalizedString("Quantity", comment: "Quantity"), attributes: placeholderAttributes)
//        amountTextField?.attributedPlaceholder = NSMutableAttributedString(string: NSLocalizedString("Amount", comment: "Amount"), attributes: placeholderAttributes)
//    }
    
    @IBAction func save() {
        
        let log = FuelLog()
        if let value = NumberFormatter().number(from: (odometerTextField?.text)!) {
            let number = CGFloat(truncating: value)
            fuelLog == nil ? (log.odometer = number) : (fuelLog?.odometer = number)
        }
        
        if let value = NumberFormatter().number(from: (quantityTextField?.text)!) {
            let number = CGFloat(truncating: value)
            fuelLog == nil ? (log.quantity = number) : (fuelLog?.quantity = number)
        }
        
        if let value = NumberFormatter().number(from: (amountTextField?.text)!) {
            let number = CGFloat(truncating: value)
            fuelLog == nil ? (log.amount = number) : (fuelLog?.amount = number)
        }
        
        fuelLog == nil ? FuelManager.shared.addLog(log) : FuelManager.shared.updateLog(fuelLog!)
    
        dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
        
      

    }
    @IBAction func cancleButton(_ sender: UIBarButtonItem) {
      navigationController?.popToRootViewController(animated: true)
      dismiss(animated: true)
    }
}


