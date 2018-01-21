//
//  Ride.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class Ride {
    
    var origin: String
    var destination: String
    var date: String
    var price: String
    var availableSpots: String
    
    init(origin: String, destination: String, date: String, price: String, availableSpots: String) {
        self.origin = origin
        self.destination = destination
        self.date = date
        self.price = price
        self.availableSpots = availableSpots
        
    }
    
    
}
