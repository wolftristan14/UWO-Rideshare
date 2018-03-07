//
//  SearchCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-22.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol SearchCoordinatorDelegate: class {
    
}

class SearchCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    var allRidesArray = [Ride]()
    
    var collRef: CollectionReference!
    var searchViewController: SearchViewController!

    
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        print("search vc start hit")
        searchViewController = navigationController?.visibleViewController?.childViewControllers[0] as! SearchViewController
        searchViewController.delegate = self
        
        //loadFirebaseData()


    }
    
    func loadFirebaseData()  {
        print("search vc loadFirebaseData hit")
        
        collRef = Firestore.firestore().collection("Rides")
        
        collRef.addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("add snapshotlistener hit")

                for document in querySnapshot!.documents {
                    print(querySnapshot?.documents.count)
                    //print("\(document.documentID) => \(document.data())")
                    let driverEmail = document.data()["driverEmail"] as! String
                    if document.data().count > 0 && driverEmail != Auth.auth().currentUser?.email {
                        let ride = Ride(docid: document.documentID, origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSeats"] as! Int, driverEmail: document.data()["driverEmail"] as! String, driverName: document.data()["driverName"] as! String,  passengers: document.data()["passengers"] as! Array, createdOn: document.data()["createdOn"] as! Date)
                    
                    
                    self.allRidesArray.append(ride)
                    print("added ride")
                    self.searchViewController.rideArray = self.allRidesArray
                    self.searchViewController.tableView.reloadData()
                    }
                    
                    if document == querySnapshot?.documents.last {
                        self.allRidesArray.removeAll()
                    }
                   
                }
            }
        }
    }

    func showRideDetail(ride: Ride) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.isParentSearchVC = true
   
        rideDetailCoordinator.start()
        
        childCoordinators.append(rideDetailCoordinator)
        
        
    }
    
    
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func didSelectRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, passengers: [String], createdOn: Date) {
        //allRidesArray.removeAll()
        let selectedRide = Ride(docid: docid, origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats, driverEmail: driverEmail, driverName: driverName, passengers: passengers, createdOn: createdOn)
        showRideDetail(ride: selectedRide)
        
    }
    
    
}

extension SearchCoordinator: RideDetailCoordinatorDelegate {
    func didAddUserToRide() {
       // allRidesArray.removeAll()
        //loadFirebaseData()
    }
    
    
}


