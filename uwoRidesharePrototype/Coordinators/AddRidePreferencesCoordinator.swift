//
//  AddRidePreferencesCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-06.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import Firebase
import UIKit

protocol AddRidePreferencesCoordinatorDelegate: class {
    func didWriteRideToFirebase()
}

class AddRidePreferencesCoordinator: NSObject {
    var navigationController: UINavigationController?
    
    weak var delegate: AddRidePreferencesCoordinatorDelegate?
    var ride: Ride?
    
    var docRef: DocumentReference!
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController

    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "AddRidePreferences", bundle: nil)
        let addRidePreferencesVC = storyboard.instantiateViewController(withIdentifier: "addridepreferences") as! AddRidePreferencesViewController
        addRidePreferencesVC.ride = ride
        addRidePreferencesVC.delegate = self as? AddRidePreferencesViewControllerDelegate
        navigationController?.pushViewController(addRidePreferencesVC, animated: true)
    }
    
    func addRideToFirebase(ride: Ride) {
        docRef = Firestore.firestore().collection("Rides").addDocument(data: [
            "docid": "",
            "driverEmail": Auth.auth().currentUser?.email ?? "error",
            "driverName": Auth.auth().currentUser?.displayName ?? "error",
            "destination": ride.destination,
            "origin": ride.origin,
            "date": ride.date,
            "price": ride.price,
            "availableSeats": ride.availableSeats,
            "createdOn": Date.init(timeIntervalSinceNow: 0),
            "passengers": [:],
            "isSmokingAllowed": ride.isSmokingAllowed,
            "willThereBeRestStops": ride.willThereBeRestStops,
            "noFoodAllowed": ride.noFoodAllowed,
            "animalsAllowed": ride.animalsAllowed,
            "baggageSize": ride.baggageSize
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
                //self.navigationController?.popToRootViewController(animated: true)
                self.delegate?.didWriteRideToFirebase()
                print("Document added with ID: \(self.docRef!.documentID)")
                
            }
        }
    }
}

extension AddRidePreferencesCoordinator: AddRidePreferencesViewControllerDelegate {
    
    
    func didAddRide(ride: Ride) {
        addRideToFirebase(ride: ride)
    }
        
        

        
    
}