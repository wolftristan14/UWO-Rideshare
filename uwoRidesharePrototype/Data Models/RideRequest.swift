//
//  RideRequest.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-01.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class RideRequest {
    
    var requesterid: String
    var rideid: String
    var createdOn: Date //(maybe make date type)
    var requestStatus: Bool
    var driverEmail: String
    
    
    init( requesterid: String, rideid: String, createdOn: Date, requestStatus: Bool, driverEmail: String) {
        self.requesterid = requesterid
        self.rideid = rideid
        self.createdOn = createdOn
        self.requestStatus = requestStatus
        self.driverEmail = driverEmail
        
    }
    
    
}
