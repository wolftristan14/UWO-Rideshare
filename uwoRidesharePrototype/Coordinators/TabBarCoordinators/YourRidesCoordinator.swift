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
    var postedRidesArray = [Ride]()
    var joinedRidesArray = [Ride]()

    
    weak var delegate: YourRidesCoordinatorDelegate?
    var collRef: CollectionReference!
    var collRefRequests: CollectionReference!
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
        loadFirebaseData()
        loadRequestsAssociatedToJoinedRides()

    }
    


    
    func loadFirebaseData()  {
        collRef = Firestore.firestore().collection("Rides")
        
        collRef.whereField("driverEmail", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.postedRidesArray.removeAll()
                if querySnapshot?.documents.count == 0 {
                    self.yourRidesViewController.postedRideArray = self.postedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                }
                
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        let ride = Ride(docid: document.documentID, origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSeats"] as! Int, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String, passengers: document.data()["passengers"] as! Array, createdOn: document.data()["createdOn"] as! Date)

                    self.postedRidesArray.append(ride)
                    //print("added ride")
                    self.yourRidesViewController.postedRideArray = self.postedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func loadRequestsAssociatedToJoinedRides() {
        collRefRequests = Firestore.firestore().collection("Requests")
        
        collRefRequests.whereField("requesterid", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").whereField("requestStatus", isEqualTo: true).addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.joinedRidesArray.removeAll()
                
                if querySnapshot?.documents.count == 0 {
                    self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                }
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        let rideid = document.data()["rideid"] as! String
                        print("rideid: \(rideid)")
                        self.loadJoinedRide(rideid: rideid)

                    }
                }
            }
        }
        
        
    }
    
    func loadJoinedRide(rideid: String) {
        docRef = Firestore.firestore().collection("Rides").document(rideid)
        
        docRef.getDocument() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                    let ride = Ride(docid: (querySnapshot?.documentID)!, origin: querySnapshot?.data()!["origin"] as! String, destination: querySnapshot?.data()!["destination"] as! String, date: querySnapshot?.data()!["date"] as! String, price: querySnapshot?.data()!["price"] as! String, availableSeats: querySnapshot?.data()!["availableSeats"] as! Int, driverEmail: querySnapshot?.data()!["driverEmail"] as! String, driverName: querySnapshot?.data()!["driverName"] as! String, passengers: querySnapshot?.data()!["passengers"] as! Array, createdOn: querySnapshot?.data()!["createdOn"] as! Date)
                        
                        self.joinedRidesArray.append(ride)
                        //print("added ride")
                        self.yourRidesViewController.joinedRidesArray = self.joinedRidesArray
                        self.yourRidesViewController.tableView.reloadData()
            }
        }
    }
    
    func goToAddRideCoordinator() {
        
        let addRideCoordinator = AddRideCoordinator(navigationController: navigationController!)
        addRideCoordinator.delegate = self as AddRideCoordinatorDelegate
        addRideCoordinator.start()
        childCoordinators.append(addRideCoordinator)
    }
    
    func showRideDetail(ride: Ride) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as? RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.isParentSearchVC = false
        rideDetailCoordinator.start()
        childCoordinators.append(rideDetailCoordinator)
        
        
    }
    
}

extension YourRidesCoordinator: YourRidesViewControllerDelegate {
    func didSelectRide(ride: Ride) {
        showRideDetail(ride: ride)
    }
    
    func didTapAddRideButton() {
        goToAddRideCoordinator()
        
    }
    
}

extension YourRidesCoordinator: AddRideCoordinatorDelegate {
    func didDismissAddRideViewController() {
           //loadFirebaseData()
        //yourRidesArray.removeAll()


    }

}

