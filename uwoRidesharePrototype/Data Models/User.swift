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
    var imageReferenceURL: String?
    
    init(firstName: String, lastName: String, imageReferenceURL: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageReferenceURL = imageReferenceURL
    }
}
