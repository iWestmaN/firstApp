//
//  FuelLogTableViewController.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/13/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import UIKit

class FuelLogTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .orange
        tableView.reloadData()
        
        
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return FuelManager.shared.fuelLogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCellIdentifier") as? LogCell
        cell?.fuelLog = FuelManager.shared.fuelLogs[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier:
            "AddLogTableViewController") as? AddLogTableViewController
        viewController?.fuelLog = FuelManager.shared.fuelLogs[indexPath.row]
        navigationController?.pushViewController(viewController!, animated: true)
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .orange
        
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt
        indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            FuelManager.shared.removeLogAt(indexPath.row)
            tableView.reloadData()
            
        }
    }
    
}
