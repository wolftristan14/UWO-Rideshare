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
    //var docRef: DocumentReference!
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
    

    
    func goToAddRidePreferencesCoordinator(ride: Ride) {
        let addRidePreferencesCoordinator = AddRidePreferencesCoordinator(navigationController: navigationController!)
        addRidePreferencesCoordinator.delegate = self as? AddRidePreferencesCoordinatorDelegate
        addRidePreferencesCoordinator.ride = ride
        addRidePreferencesCoordinator.start()
        childCoordinators.append(addRidePreferencesCoordinator)
        
    }

}

extension AddRideCoordinator: AddRideViewControllerDelegate {

    
    func didContinueCreatingRide(docid: String, origin: String, destination: String, date: String, price: String, availableSeats: Int, driverEmail: String, driverName: String, driverUID: String, createdOn: Date) {
        let ride = Ride(docid: docid, origin: origin, destination: destination, date: date, price: price, availableSeats: availableSeats, driverEmail: driverEmail, driverName: driverName, driverUID: driverUID, createdOn: createdOn, isSmokingAllowed: false, willThereBeRestStops: false, noFoodAllowed: false, animalsAllowed: false, baggageSize: "")
        goToAddRidePreferencesCoordinator(ride: ride)
        
        
        
    }
}

extension AddRideCoordinator: AddRidePreferencesCoordinatorDelegate {
    func didWriteRideToFirebase() {
        delegate?.didDismissAddRideViewController()
        navigationController?.popViewController(animated: true)
        
    }
}
