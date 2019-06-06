//
//  FuelLog.swift
//  firstApp
//
//  Created by Igor Lishchenko on 2/13/19.
//  Copyright © 2019 Igor Lishchenko. All rights reserved.
//

import Foundation
import UIKit

public class FuelLog: NSObject, NSCoding {
    
    public var odometer: CGFloat = 0.0
    public var quantity: CGFloat = 0.0
    public var amount: CGFloat = 0.0
    var distanceInKiloMeter: CGFloat = 0.0
    var litersPerOneHundredKm: CGFloat = 0.0
    var pricePerLitre: CGFloat = 0.0
    
    override init() {
        super.init()
        
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(odometer, forKey:"odometer")
        aCoder.encode(quantity, forKey:"quantity")
        aCoder.encode(amount, forKey:"amount")
        aCoder.encode(distanceInKiloMeter, forKey:"distanceInKiloMeter")
        aCoder.encode(litersPerOneHundredKm, forKey:"litersPerOneHundredKm")
        aCoder.encode(pricePerLitre, forKey:"pricePerLitre")
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        
        super.init()
        odometer = aDecoder.decodeObject(forKey: "odometer") as! CGFloat
        quantity = aDecoder.decodeObject(forKey: "quantity") as! CGFloat
        amount = aDecoder.decodeObject(forKey: "amount") as! CGFloat
        distanceInKiloMeter = aDecoder.decodeObject(forKey: "distanceInKiloMeter") as! CGFloat
        litersPerOneHundredKm = aDecoder.decodeObject(forKey: "litersPerOneHundredKm") as! CGFloat
        pricePerLitre = aDecoder.decodeObject(forKey: "pricePerLitre") as! CGFloat
        
        UserDefaults.standard.set(litersPerOneHundredKm, forKey: "numbers")
        
    }
}
