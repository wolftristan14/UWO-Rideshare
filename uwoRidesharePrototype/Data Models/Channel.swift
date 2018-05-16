//
//  Channel.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-16.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

class Channel {
    
    var name: String
    var members: [String:Bool]
    
    
    init(name: String, members: [String:Bool]) {
        self.name = name
        self.members = members
    }
}
