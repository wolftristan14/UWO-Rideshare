//
//  User.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-19.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var name: String
    var phoneNumber: String
    var email: String
    var imageDownloadURL: String?
    var notificationTokens: [String]
    var image: UIImage?
    var rating: Double?
    var numRatings: Double?
    
    
    init(name: String, phoneNumber: String, email: String, imageDownloadURL: String?, notificationTokens: [String], image: UIImage?, rating: Double?, numRatings: Double?) {
        
        self.name = name
        self.imageDownloadURL = imageDownloadURL
        self.phoneNumber = phoneNumber
        self.email = email
        self.notificationTokens = notificationTokens
        self.image = image
        self.rating = rating
        self.numRatings = numRatings
    
    }
}
