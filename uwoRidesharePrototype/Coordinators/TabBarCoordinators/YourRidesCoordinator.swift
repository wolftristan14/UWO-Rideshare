//
//  YourRidesCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-22.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol YourRidesCoordinatorDelegate: class {
    
}

class YourRidesCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    var postedRidesArray = [RideRecord]()
    var joinedRidesArray = [RideRecord]()

    
    weak var delegate: YourRidesCoordinatorDelegate?
    var postedRidesCollRef: CollectionReference!
    var fullRidesCollRef: CollectionReference!
    var joinedRidesQuery: Query!
    var joinedFullRidesQuery: Query!
    var docRef: DocumentReference!
    var yourRidesViewController: YourRidesViewController!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = false
    }
    
    func start() {
        yourRidesViewController = navigationController?.visibleViewController?.childViewControllers[1] as! YourRidesViewController
        yourRidesViewController.delegate = self

        loadPostedRides()
        loadPostedFullRides()
        loadJoinedRides()

    }
    


    
    func loadPostedRides()  {
        self.yourRidesViewController.postedRideArray = self.postedRidesArray
        postedRidesCollRef = Firestore.firestore().collection("Rides")
        
        postedRidesCollRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {

                //if querySnapshot?.documents.count == 0 {
                    
                    //self.yourRidesViewController.postedRideArray = self.postedRidesArray
                   // self.yourRidesViewController.tableView.reloadData()
               // }
                
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {

                    
                        let newRide = RideRecord(json: document.data(), id: document.documentID)
                        //ride.docid = document.documentID

                    //self.postedRidesArray.append(newRide)
                        var index = 0
                        for ride in self.postedRidesArray {
                            if ride.docid == newRide.docid {
                             self.postedRidesArray.remove(at: index)
                            } else {
                                index += 1
                            }
                        }
                    self.postedRidesArray.append(newRide)

                    //print("added ride")
                    self.yourRidesViewController.postedRideArray = self.postedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                    }
                }
            }
        }

        
    }
    
    func loadPostedFullRides() {
        fullRidesCollRef = Firestore.firestore().collection("FullRides")
        
        fullRidesCollRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //self.postedRidesArray.removeAll()
                // if querySnapshot?.documents.count == 0 {
                // self.yourRidesViewController.postedRideArray = self.postedRidesArray
                // self.yourRidesViewController.tableView.reloadData()
                //}
                
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        
                        let newRide = RideRecord(json: document.data(), id: document.documentID)
                        //ride.docid = document.documentID
                        var index = 0
                        for ride in self.postedRidesArray {
                            if ride.docid == newRide.docid {
                                self.postedRidesArray.remove(at: index)
                            } else {
                                index += 1
                            }
                        }
                        
                        self.postedRidesArray.append(newRide)
                        //print("added ride")
                        self.yourRidesViewController.postedRideArray = self.postedRidesArray
                        self.yourRidesViewController.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func loadJoinedRides() {
        self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
        let userUID = Auth.auth().currentUser?.uid ?? ""
        joinedRidesQuery = Firestore.firestore().collection("Rides").whereField("passengers.\(userUID)", isEqualTo: true)
        //print("userDisplayName:\(userDisplayName)")

            joinedRidesQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //self.joinedRidesArray.removeAll()
//                if querySnapshot?.documents.count == 0 {
//                    self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
//                    self.yourRidesViewController.tableView.reloadData()
//                }
                //print(querySnapshot?.documents.count)
                for document in querySnapshot!.documents {
                    let newRide = RideRecord(json: document.data(), id: document.documentID)
                    
                    var index = 0
                    for ride in self.joinedRidesArray {
                        if ride.docid == newRide.docid {
                            self.joinedRidesArray.remove(at: index)
                        } else {
                            index += 1
                        }
                    }
                    
                    self.joinedRidesArray.append(newRide)
                    //print("added ride")
                    self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                    //print(document.data())

                }
            }
        }
        
        joinedFullRidesQuery = Firestore.firestore().collection("FullRides").whereField("passengers.\(userUID)", isEqualTo: true/*[userUID: true]*/)
        //print("userDisplayName:\(userDisplayName)")
        
        joinedFullRidesQuery.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //self.joinedRidesArray.removeAll()
//                if querySnapshot?.documents.count == 0 {
//                    self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
//                    self.yourRidesViewController.tableView.reloadData()
//                }
                //print(querySnapshot?.documents.count)
                for document in querySnapshot!.documents {
                    let newRide = RideRecord(json: document.data(), id: document.documentID)
                    
                    var index = 0
                    for ride in self.joinedRidesArray {
                        if ride.docid == newRide.docid {
                            self.joinedRidesArray.remove(at: index)
                        } else {
                            index += 1
                        }
                    }
                    
                    self.joinedRidesArray.append(newRide)
                    //print("added ride")
                    self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                    //print(document.data())
                    
                }
            }
        }
        
        
    }
    

    
    func goToAddRideCoordinator() {
        
        let addRideCoordinator = AddRideCoordinator(navigationController: navigationController!)
        addRideCoordinator.delegate = self as AddRideCoordinatorDelegate
        addRideCoordinator.start()
        childCoordinators.append(addRideCoordinator)
    }
    
    func showRideDetail(ride: RideRecord) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as? RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.isParentSearchVC = false
        rideDetailCoordinator.start()
        childCoordinators.append(rideDetailCoordinator)


    }
    
}

extension YourRidesCoordinator: YourRidesViewControllerDelegate {
    func didSelectRide(ride: RideRecord) {
        showRideDetail(ride: ride)
    }
    
    func didTapAddRideButton() {
        goToAddRideCoordinator()
        
    }
    
}

extension YourRidesCoordinator: AddRideCoordinatorDelegate {
    func didDismissAddRideViewController() {
        self.postedRidesArray.removeAll()
        loadPostedFullRides()
           //loadFirebaseData()
        //yourRidesArray.removeAll()


    }

}

