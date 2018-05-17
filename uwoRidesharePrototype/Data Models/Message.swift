//
//  Message.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-17.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation

class Message {

    var text: String
    var senderid: String


    init(text: String, senderid: String) {
        self.text = text
        self.senderid = senderid
    }
}
