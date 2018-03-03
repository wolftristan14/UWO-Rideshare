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
    var createdOn: String //(maybe make date type)
    var requestStatus: Bool
    
    
    init( requesterid: String, rideid: String, createdOn: String, requestStatus: Bool) {
        self.requesterid = requesterid
        self.rideid = rideid
        self.createdOn = createdOn
        self.requestStatus = requestStatus
        
    }
    
    
}
