//
//  User.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class User {
    
    var firstName: String
    var lastName: String
    var imageDownloadURL: String?
    
    init(firstName: String, lastName: String, imageDownloadURL: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageDownloadURL = imageDownloadURL
    }
}
