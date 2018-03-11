//
//  RequestsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-03.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit


protocol RequestsViewControllerDelegate: class {
    func didSelectRequest(request: RideRequest, didUseRequestsArray: Bool)
}

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var requestsArray = [RideRequest]()
    var requestedArray = [RideRequest]()
    weak var delegate: RequestsViewControllerDelegate?

    
    override func viewDidLoad() {
        print("requestsvc view did load hit")
        super.viewDidLoad()
        tableView.rowHeight = 78
        
    }
    

    override func viewWillAppear(_ animated: Bool) {


    self.tabBarController?.navigationItem.title = "Requests"
    
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //print("request vc number of sections method hit")
          return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("request vc number of rows in section method hit")
        if section == 0 {
        return requestsArray.count
        } else {
            return requestedArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("request vc cell for row method hit")
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath) as! RequestsTableViewCell
        
        if indexPath.section == 0 {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath) as! RequestsTableViewCell
        let request = requestsArray[indexPath.row]
        cell.requesteridLabel.text = "Ride Request from: \(request.requesterName)"
        return cell
        } else {
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "requested", for: indexPath) as! RequestedTableViewCell
        let requested = requestedArray[indexPath.row]
        cell.requesteridLabel.text = "Pending Approval From: \(requested.driverName)"
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //print("title for header method hit")
        if section == 0 {
            return "Requests"
        } else {
            return "Requested"
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath[0] == 0 {
            let request = requestsArray[indexPath[1]]
            delegate?.didSelectRequest(request: request, didUseRequestsArray: true)
            
        } else {
            let request = requestedArray[indexPath[1]]
            delegate?.didSelectRequest(request: request, didUseRequestsArray: false)
        }
    }

}
