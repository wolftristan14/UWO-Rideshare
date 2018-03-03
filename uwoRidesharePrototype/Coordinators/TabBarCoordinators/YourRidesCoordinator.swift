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
    var yourRidesArray = [Ride]()

    
    weak var delegate: YourRidesCoordinatorDelegate?
    var collRef: CollectionReference!
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


    }
    


    
    func loadFirebaseData()  {
        collRef = Firestore.firestore().collection("Rides")
        
        collRef.whereField("driver", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        let ride = Ride(docid: document.documentID, origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSeats"] as! Int, driver: document.data()["driver"] as! String, passengers: document.data()["passengers"] as! Array, createdOn: document.data()["createdOn"] as! Date)

                    self.yourRidesArray.append(ride)
                    //print("added ride")
                    self.yourRidesViewController.rideArray = self.yourRidesArray
                    self.yourRidesViewController.tableView.reloadData()
                    }
                }
            }
        }
        
//        collRef { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    if document.data().count > 0 {
//                        let ride = Ride(origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSpots"] as! Int, driver: document.data()["driver"] as! String, passengers: document.data()["passengers"] as! Array)
//
//                        self.yourRidesArray.append(ride)
//                        print("added ride")
//                        self.yourRidesViewController.rideArray = self.yourRidesArray
//                        self.yourRidesViewController.tableView.reloadData()
//                    }
//                }
//            }
//        }
        
        
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
    func didSelectRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driver: String, passengers: [String], createdOn: Date) {
        let selectedRide = Ride(docid: docid, origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats, driver: driver, passengers: passengers, createdOn: createdOn)
        showRideDetail(ride: selectedRide)
    }
    
    func didTapAddRideButton() {
        goToAddRideCoordinator()
        
    }
    
}

extension YourRidesCoordinator: AddRideCoordinatorDelegate {
    func didDismissAddRideViewController() {
           //loadFirebaseData()
        yourRidesArray.removeAll()


    }

}

