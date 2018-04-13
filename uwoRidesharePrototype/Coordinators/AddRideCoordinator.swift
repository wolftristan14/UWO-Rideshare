//
//  AddRideCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-20.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol AddRideCoordinatorDelegate: class {
    func didDismissAddRideViewController()
}

class AddRideCoordinator: NSObject {
    
    var navigationController: UINavigationController?

    weak var delegate: AddRideCoordinatorDelegate?
    var docRef: DocumentReference!
    var childCoordinators = [NSObject]()

    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "AddRide", bundle: nil)
        let addRideVC = storyboard.instantiateViewController(withIdentifier: "addride") as! AddRideViewController
        addRideVC.delegate = self as AddRideViewControllerDelegate
        navigationController?.pushViewController(addRideVC, animated: true)
    }
    
//    func addRideToDatabase(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, createdOn: Date) {
//        print("ride added to database")
//
//    docRef = Firestore.firestore().collection("Rides").addDocument(data:[
//
//    "docid": "",
//    "driverEmail": Auth.auth().currentUser?.email ?? "error",
//    "driverName": Auth.auth().currentUser?.displayName ?? "error",
//    "destination": destination,
//    "origin": origin,
//    "date": date,
//    "price": price,
//    "availableSeats": availableSeats,
//    "createdOn": Date.init(timeIntervalSinceNow: 0),
//    "passengers": [:]
//    ]) { err in
//    if let err = err {
//    print("Error adding document: \(err)")
//    } else {
//    self.navigationController?.popViewController(animated: true)
//    self.delegate?.didDismissAddRideViewController()
//    print("Document added with ID: \(self.docRef!.documentID)")
//
//    }
//
//    }
    

        
//}
    
    func goToAddRidePreferencesCoordinator(ride: Ride) {
        let addRidePreferencesCoordinator = AddRidePreferencesCoordinator(navigationController: navigationController!)
        addRidePreferencesCoordinator.delegate = self as? AddRidePreferencesCoordinatorDelegate
        addRidePreferencesCoordinator.ride = ride
        addRidePreferencesCoordinator.start()
        childCoordinators.append(addRidePreferencesCoordinator)
        
    }

    

    
}

extension AddRideCoordinator: AddRideViewControllerDelegate {

    
    func didContinueCreatingRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, createdOn: Date) {
        let ride = Ride(docid: docid, origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats, driverEmail: driverEmail, driverName: driverName, createdOn: createdOn, isSmokingAllowed: false, willThereBeRestStops: false, noFoodAllowed: false, animalsAllowed: false, baggageSize: "")
        goToAddRidePreferencesCoordinator(ride: ride)
        
        
        
    }
}

extension AddRideCoordinator: AddRidePreferencesCoordinatorDelegate {
    func didWriteRideToFirebase() {
        delegate?.didDismissAddRideViewController()
        navigationController?.popViewController(animated: true)
        
    }
}
