//
//  RequestsCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-03-03.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol RequestsCoordinatorDelegate: class {
    
}

class RequestsCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var requestsViewController: RequestsViewController!
    //var childCoordinators = [NSObject]()
    var requestsArray = [RideRequest]()
    
    
    weak var delegate: RequestsCoordinatorDelegate?
   // var docRef: DocumentReference!
    var collRef: CollectionReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        requestsViewController = navigationController?.visibleViewController?.childViewControllers[4] as! RequestsViewController
        //requestsViewController.delegate = self
        loadFirebaseData()
        
        
    }
    
    
    
    
    func loadFirebaseData()  {
        collRef = Firestore.firestore().collection("Requests")
        
        collRef.whereField("driveremail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        let request = RideRequest(requesterid: document.data()["requesterid"] as! String, rideid: document.data()["rideid"] as! String, createdOn: document.data()["createdOn"] as! Date, requestStatus: document.data()["requestStatus"] as! Bool)
                        
                        self.requestsArray.append(request)
                        //print("added ride")
                        self.requestsViewController.requestsArray = self.requestsArray
                        self.requestsViewController.tableView.reloadData()
                    }
                }
            }
        }
        

        
        
    }
    
    
}
