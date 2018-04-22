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
    var childCoordinators = [NSObject]()
    var requestsArray = [RideRequest]()
    var requestedArray = [RideRequest]()

    
    
    weak var delegate: RequestsCoordinatorDelegate?
   // var docRef: DocumentReference!
    var loadRequestsCollRef: CollectionReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        requestsViewController = navigationController?.visibleViewController?.childViewControllers[4] as! RequestsViewController
        requestsViewController.delegate = self
        self.requestsViewController.tableView.reloadData()
        loadFirebaseData()
        
        
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
                self.requestsViewController.requestsArray = self.requestsArray
                self.requestsViewController.tableView.reloadData()
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
                        self.requestsViewController.requestsArray = self.requestsArray
                        self.requestsViewController.tableView.reloadData()
                    }
                }
            }
        }
        
        loadRequestsCollRef.whereField("requesterid", isEqualTo: Auth.auth().currentUser?.email ?? "error")
            .whereField("requestStatus", isEqualTo: false).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.requestedArray.removeAll()
                    
                    if querySnapshot?.documents.count == 0 {
                        self.requestsViewController.requestedArray = self.requestedArray
                        self.requestsViewController.tableView.reloadData()
                    }
                    
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        if document.data().count > 0 {
                            //print(document)
                            let request = RideRequest(docid: document.data()["docid"] as! String, requesterid: document.data()["requesterid"] as! String, requesterName: document.data()["requesterName"] as! String, rideid: document.data()["rideid"] as! String, createdOn: document.data()["createdOn"] as! Date, requestStatus: document.data()["requestStatus"] as! Bool, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String, driverUID: document.data()["driverUID"] as! String)
                            
                            self.requestedArray.append(request)
                            //print("added ride")
                            self.requestsViewController.requestedArray = self.requestedArray
                            self.requestsViewController.tableView.reloadData()
                        }
                    }
                }
        }
                
        
        

        
        
    }
    
    func showRequestDetail(request: RideRequest, didUseRequestsArray: Bool) {
        print("request: \(request.requesterid)")
    let requestDetailCoordinator = RequestDetailCoordinator(navigationController: navigationController!)
    requestDetailCoordinator.selectedRequest = request
    requestDetailCoordinator.didUseRequestsArray = didUseRequestsArray
    requestDetailCoordinator.delegate = self as? RequestDetailCoordinatorDelegate
    requestDetailCoordinator.start()
    childCoordinators.append(requestDetailCoordinator)
    }
}

extension RequestsCoordinator: RequestsViewControllerDelegate {
    
    func didSelectRequest(request: RideRequest, didUseRequestsArray: Bool) {
        showRequestDetail(request: request, didUseRequestsArray: didUseRequestsArray)
    }
    
}

