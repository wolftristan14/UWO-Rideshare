//
//  RideRequest.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-01.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class RideRequest {
    
    var docid: String
    var requesterid: String
    var requesterName: String
    var rideid: String
    var createdOn: Date 
    var requestStatus: Bool
    var driverEmail: String
    var driverName: String

    
    
    init(docid: String, requesterid: String, requesterName: String, rideid: String, createdOn: Date, requestStatus: Bool, driverEmail: String, driverName: String) {
        self.docid = docid
        self.requesterid = requesterid
        self.requesterName = requesterName
        self.rideid = rideid
        self.createdOn = createdOn
        self.requestStatus = requestStatus
        self.driverEmail = driverEmail
        self.driverName = driverName
        
    }
    
    
}
