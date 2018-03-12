//
//  MessagesViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            print("iOS 11 available")
            
            self.tabBarController?.navigationItem.searchController = nil
        } else {
            print("iOS 11 not available")
            
            // Fallback on earlier versions
        }
        
        self.tabBarController?.navigationItem.title = "Messages"
        
        
    }


}
