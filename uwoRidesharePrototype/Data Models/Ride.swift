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
    var availableSeats: String
    var driver: String
    
    init(origin: String, destination: String, date: String, price: String, availableSeats: String, driver: String) {
        self.origin = origin
        self.destination = destination
        self.date = date
        self.price = price
        self.availableSeats = availableSeats
        self.driver = driver
    }
    
    
}
