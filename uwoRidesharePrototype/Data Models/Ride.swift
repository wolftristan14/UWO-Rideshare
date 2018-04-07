//
//  Ride.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-06.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class Ride {

    var docid: String?
    var origin: String?
    var destination: String?
    var date: String?
    var price: String?
    var availableSeats: Int?
    var driverEmail: String?
    var driverName: String?
    var passengers: [String:Any]?
    var createdOn: Date?
    var isSmokingAllowed: Bool?
    var willThereBeRestStops: Bool?
    var noFoodAllowed: Bool?
    var animalsAllowed: Bool?
    var baggageSize: String?
    

    
    init(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, createdOn: Date, isSmokingAllowed: Bool, willThereBeRestStops: Bool, noFoodAllowed: Bool, animalsAllowed: Bool, baggageSize: String) {
        self.docid = docid
        self.origin = origin
        self.destination = destination
        self.date = date
        self.price = price
        self.availableSeats = availableSeats
        self.driverEmail = driverEmail
        self.driverName = driverName
        self.createdOn = createdOn
        self.isSmokingAllowed = isSmokingAllowed
        self.willThereBeRestStops = willThereBeRestStops
        self.noFoodAllowed = noFoodAllowed
        self.animalsAllowed = animalsAllowed
        self.baggageSize = baggageSize
        
    }

    
}
