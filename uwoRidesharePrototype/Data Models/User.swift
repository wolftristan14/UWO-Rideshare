//
//  User.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var phoneNumber: String
    var email: String
    var imageDownloadURL: String?
    
    
    init(name: String, phoneNumber: String, email: String, imageDownloadURL: String?) {
        
        self.name = name
        self.imageDownloadURL = imageDownloadURL
        self.phoneNumber = phoneNumber
        self.email = email
    
    }
}
