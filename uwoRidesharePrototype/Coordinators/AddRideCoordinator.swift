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
    
    func addRideToDatabase(ride: Ride) {
        print("ride added to database")
        print(ride.destination)
        print(ride.origin)
        print(ride.date)
        print(ride.price)
        print(ride.availableSeats)
        
        docRef = Firestore.firestore().document("Rides/\(ride.origin) to \(ride.destination), \(ride.date)")
        docRef.setData([
            "driver": Auth.auth().currentUser?.email ?? "error",
            "destination": ride.destination,
            "origin": ride.origin,
            "date": ride.date,
            "price": ride.price,
            "availableSpots": ride.availableSeats
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.didDismissAddRideViewController()
            print("Document added with ID: \(self.docRef!.documentID)")
                
            }

        }
    }
    
}

extension AddRideCoordinator: AddRideViewControllerDelegate {
    func didAddRide(origin: String, destination: String, date: String, price: String, availableSeats: String) {
        //navigationController?.popViewController(animated: true)
        let ride = Ride(origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats)
        addRideToDatabase(ride: ride)
    }
}
