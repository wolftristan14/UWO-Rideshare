//
//  RideRecord.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import AlgoliaSearch
//import InstantSearchCore
import Foundation

struct RideRecord {
    private var json: JSONObject
    //private let MAX_BEST_SELLING_RANK = 32691;
    
    init(json: JSONObject) {
        self.json = json
    }
    
    var docid: String? {
        return json["docid"] as? String
    }
    
    var origin: String? {
        return json["origin"] as? String
    }
    
    var destination: String? {
        return json["destination"] as? String
    }
    
    var date: String? {
        return json["date"] as? String
    }
    
    
    var price: String? {
        return json["price"] as? String
    }
    
    var availableSeats: Int? {
        return json["availableSeats"] as? Int
    }
    
    var driverEmail: String? {
        return json["driverEmail"] as? String
    }
    
    var driverName: String? {
        return json["driverName"] as? String
    }
    
    var passengers: [String:Any]? {
        return json["passengers"] as? [String:Any]
    }
    
    var createdOn: Date? {
        return json["createdOn"] as? Date
    }
    
    var isSmokingAllowed: Bool? {
        return json["isSmokingAllowed"] as? Bool
    }
    var willThereBeRestStops: Bool? {
        return json["willThereBeRestStops"] as? Bool

    }
    var noFoodAllowed: Bool? {
        return json["noFoodAllowed"] as? Bool

    }
    var animalsAllowed: Bool? {
        return json["animalsAllowed"] as? Bool

    }
    var baggageSize: String? {
        return json["baggageSize"] as? String

    }
    
    var driverRating: Int? {
        return json["driverRating"] as? Int
    }
    

    
    


}
