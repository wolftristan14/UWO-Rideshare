//
//  RequestsViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-03.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase


protocol RequestsViewControllerDelegate: class {
    func didSelectRequest(request: RideRequest, didUseRequestsArray: Bool)
}

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var requestsArray = [RideRequest]()
    var requestedArray = [RideRequest]()
    var oldConstraintArray = [NSLayoutConstraint]()
    var newConstraintArray = [NSLayoutConstraint]()
    weak var delegate: RequestsViewControllerDelegate?
    
    var loadRequestsCollRef: CollectionReference!


    
    override func viewDidLoad() {
        print("requestsvc view did load hit")
        super.viewDidLoad()
        tableView.rowHeight = 78
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
      

    loadFirebaseData()
    tableView.reloadData()
    self.tabBarController?.navigationItem.title = "Requests"
    
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "requests", for: indexPath) as! RequestsTableViewCell
        
        if indexPath.section == 0 {

        let request = requestsArray[indexPath.row]
        cell.requesteridLabel.text = "Ride Request from: \(request.requesterName)"
        return cell
        } else {

        let requested = requestedArray[indexPath.row]
        cell.requesteridLabel.text = "Pending Approval From: \(requested.driverName)"
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func loadFirebaseData()  {
        loadRequestsCollRef = Firestore.firestore().collection("Requests")
        
        loadRequestsCollRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR")
            .whereField("requestStatus", isEqualTo: false)
            .addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("hit first request query")
                    self.requestsArray.removeAll()
                    
                    if querySnapshot?.documents.count == 0 {
                        self.tableView.reloadData()
                    }
                    print("querysnapshot.documents:\(querySnapshot?.documents)")
                    for document in querySnapshot!.documents {
                        print("document.data.count:\(document.data().count)")
                        //print("\(document.documentID) => \(document.data())")
                        if document.data().count > 0 {
                            
                            let request = RideRequest(docid: document.documentID, requesterid: document.data()["requesterid"] as! String, requesterName: document.data()["requesterName"] as! String, rideid: document.data()["rideid"] as! String, createdOn: document.data()["createdOn"] as! Date, requestStatus: document.data()["requestStatus"] as! Bool, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String, driverUID: document.data()["driverUID"] as! String)
                            print("made it thorugh first request query")
                            self.requestsArray.append(request)
                            //print("added ride")
                            self.tableView.reloadData()
                        }
                    }
                }
        }
        
        loadRequestsCollRef.whereField("requesterid", isEqualTo: Auth.auth().currentUser?.uid ?? "error")
            .whereField("requestStatus", isEqualTo: false).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.requestedArray.removeAll()
                    
                    if querySnapshot?.documents.count == 0 {
                        self.tableView.reloadData()
                    }
                    
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        if document.data().count > 0 {
                            //print(document)
                            let request = RideRequest(docid: document.data()["docid"] as! String, requesterid: document.data()["requesterid"] as! String, requesterName: document.data()["requesterName"] as! String, rideid: document.data()["rideid"] as! String, createdOn: document.data()["createdOn"] as! Date, requestStatus: document.data()["requestStatus"] as! Bool, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String, driverUID: document.data()["driverUID"] as! String)
                            
                            self.requestedArray.append(request)
                            //print("added ride")
                           // self.requestsViewController.requestedArray = self.requestedArray
                            self.tableView.reloadData()
                        }
                    }
                }
        }

}
    
    
}
