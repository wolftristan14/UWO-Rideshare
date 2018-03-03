//
//  RequestsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-03.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit


class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //print("request vc number of sections method hit")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("request vc number of rows in section method hit")

        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("request vc cell for row method hit")
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //print("title for header method hit")
        if section == 0 {
            return "Requests"
        } else {
            return "Requested"
        }
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    

override func viewWillAppear(_ animated: Bool) {
    
    self.tabBarController?.navigationItem.title = "Requests"
    
    
}

}
