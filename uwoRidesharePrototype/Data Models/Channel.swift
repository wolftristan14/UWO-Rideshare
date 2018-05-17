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
    var rideid: String
    var channelid: String?
    
    
    init(name: String, members: [String:Bool], rideid: String, channelid: String?) {
        
        self.name = name
        self.members = members
        self.rideid = rideid
        self.channelid = channelid
        
    }
}
