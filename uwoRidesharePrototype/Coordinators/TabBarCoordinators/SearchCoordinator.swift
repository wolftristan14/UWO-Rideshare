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
    var docRef: DocumentReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        searchViewController = navigationController?.visibleViewController?.childViewControllers[0] as! SearchViewController
        loadFirebaseData()


    }
    
    func loadFirebaseData()  {
        allRidesArray.removeAll()
        
        
        collRef = Firestore.firestore().collection("Rides")
        
        collRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let ride = Ride(origin: document.data()["origin"] as! String, destination: document.data()["destination"] as! String, date: document.data()["date"] as! String, price: document.data()["price"] as! String, availableSeats: document.data()["availableSpots"] as! String)
                    
                    self.allRidesArray.append(ride)
                    print("added ride")
                    self.searchViewController.rideArray = self.allRidesArray
                    self.searchViewController.tableView.reloadData()
                }
            }
        }
    }

    
}


