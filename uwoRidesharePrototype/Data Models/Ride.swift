//
//  Ride.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class Ride {
    
    var docid: String
    var origin: String
    var destination: String
    var date: String
    var price: String
    var availableSeats: Int
    var driverEmail: String
    var driverName: String
    var passengers: [String]
    var createdOn: Date
    //var luggageSize: String
    
    init(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, passengers: [String], createdOn: Date /*luggageSize: String*/) {
        
        self.docid = docid
        self.origin = origin
        self.destination = destination
        self.date = date
        self.price = price
        self.availableSeats = availableSeats
        self.driverEmail = driverEmail
        self.driverName = driverName
        self.passengers = passengers
        self.createdOn = createdOn
        //self.luggageSize = luggageSize
        
    }
    
    
}
