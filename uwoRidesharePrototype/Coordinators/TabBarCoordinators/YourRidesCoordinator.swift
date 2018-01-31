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
            yourRidesArray.removeAll()
       
        
//        collRef = Firestore.firestore().collection("users").document((Auth.auth().currentUser?.email)!).collection("postedRides")
        collRef = Firestore.firestore().collection("Rides")
        
        collRef.whereField("driver", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let ride = Ride(origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSpots"] as! String)
                    
                    self.yourRidesArray.append(ride)
                    print("added ride")
                    self.yourRidesViewController.rideArray = self.yourRidesArray
                    self.yourRidesViewController.tableView.reloadData()
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
    
}

extension YourRidesCoordinator: YourRidesViewControllerDelegate {
    func didTapAddRideButton() {
        goToAddRideCoordinator()
        
    }
    
}

extension YourRidesCoordinator: AddRideCoordinatorDelegate {
    func didDismissAddRideViewController() {
        print("loadingfirebasedata")
        yourRidesViewController.tableView.reloadData()
        loadFirebaseData()

    }

}

