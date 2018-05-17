//
//  ChatViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-05-17.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import UIKit
import NMessenger

protocol ChatViewControllerDelegate: class {
    
}

class ChatViewController: NMessengerViewController {
    
    weak var delegate: ChatViewControllerDelegate?
    var selectedChannel: Channel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
