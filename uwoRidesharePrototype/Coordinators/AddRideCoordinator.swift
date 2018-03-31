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
    
    func addRideToDatabase(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, createdOn: Date) {
        print("ride added to database")

    docRef = Firestore.firestore().collection("Rides").addDocument(data:[
        
    "docid": "",
    "driverEmail": Auth.auth().currentUser?.email ?? "error",
    "driverName": Auth.auth().currentUser?.displayName ?? "error",
    "destination": destination,
    "origin": origin,
    "date": date,
    "price": price,
    "availableSeats": availableSeats,
    "createdOn": Date.init(timeIntervalSinceNow: 0),
    "passengers": [:]
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

    
    func didAddRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, createdOn: Date) {
        addRideToDatabase(docid: docid, origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats, driverEmail: driverEmail, driverName: driverName, createdOn: createdOn)
        
    }
}
