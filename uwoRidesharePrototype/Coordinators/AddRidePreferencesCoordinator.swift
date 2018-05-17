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
    
    var addRideDocRef: DocumentReference!
    var addChannelDocRef: DocumentReference!
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
        addRideDocRef = Firestore.firestore().collection("Rides").addDocument(data: [
            "docid": "",
            "driverEmail": Auth.auth().currentUser?.email ?? "error",
            "driverName": Auth.auth().currentUser?.displayName ?? "error",
            "driverUID": Auth.auth().currentUser?.uid ?? "error",
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
            "baggageSize": ride.baggageSize,
            "driverRating": 5
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
                //self.navigationController?.popToRootViewController(animated: true)
                self.delegate?.didWriteRideToFirebase()
                print("Document added with ID: \(self.addRideDocRef!.documentID)")
                ride.docid = self.addRideDocRef.documentID
                self.addChatChannelForRide(ride: ride)
                
            }
        }
    }
    
    func addChatChannelForRide(ride: Ride) {
        
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        addChannelDocRef = Firestore.firestore().collection("Channels").addDocument(data:
            ["name": "\(ride.origin ?? "") to \(ride.destination ?? "")",
            "members": [uid : true],
            "rideid": ride.docid ?? ""
        ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            //self.navigationController?.popViewController(animated: true)
                            //self.navigationController?.popToRootViewController(animated: true)
                            //self.delegate?.didWriteRideToFirebase()
                            print("Document added with ID: \(self.addChannelDocRef?.documentID)")
            
            }
            
        }
    }
}

extension AddRidePreferencesCoordinator: AddRidePreferencesViewControllerDelegate {
    
    
    func didAddRide(ride: Ride) {
        addRideToFirebase(ride: ride)
        //addChatChannelForRide(ride: ride)
    }
        
        

        
    
}
