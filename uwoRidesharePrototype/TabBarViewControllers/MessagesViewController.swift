//
//  MessagesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import NMessenger

class MessagesViewController: UIViewController {

    //var messengerView: NMessenger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let messengerView = NMessenger(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        messengerView.delegate = self as? NMessengerDelegate
        self.view.addSubview(messengerView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {


        self.tabBarController?.navigationItem.title = "Messages"
        
        
    }


}
