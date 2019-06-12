//
//  LogCell.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/13/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    @IBOutlet weak var distanceLabel: UILabel?
    @IBOutlet weak var mileageLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    
    public var fuelLog: FuelLog? {
        didSet {
            if let distance = fuelLog?.distanceInKiloMeter {
                distanceLabel?.text = "\(distance.roundTo(places: 2)) \(NSLocalizedString("km", comment: "km"))"
            }
            
            if let consumption = fuelLog?.litersPerOneHundredKm {
                priceLabel?.text = "\(consumption.roundTo(places: 2))"
            }
            
            if let price = fuelLog?.pricePerLitre {
                mileageLabel?.text = "\(price.roundTo(places: 2)) \(NSLocalizedString("$/liter", comment: "$/liter"))"
            }
        }
    }
}
