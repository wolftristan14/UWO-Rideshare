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

    weak var delegate: YourRidesCoordinatorDelegate?

    var yourRidesViewController: YourRidesViewController!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = false
    }
    
    func start() {
        yourRidesViewController = navigationController?.visibleViewController?.childViewControllers[1] as! YourRidesViewController
        yourRidesViewController.delegate = self


    }

    func goToAddRideCoordinator() {
        
        let addRideCoordinator = AddRideCoordinator(navigationController: navigationController!)
        addRideCoordinator.delegate = self as? AddRideCoordinatorDelegate
        addRideCoordinator.start()
        childCoordinators.append(addRideCoordinator)
    }
    
    func showRideDetail(ride: RideRecord, postedRide: Bool) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.postedRide = postedRide
        rideDetailCoordinator.isParentSearchVC = false
        rideDetailCoordinator.start()
        childCoordinators.append(rideDetailCoordinator)


    }
    
}

extension YourRidesCoordinator: YourRidesViewControllerDelegate {
    func didSelectRide(ride: RideRecord, postedRide: Bool) {
        showRideDetail(ride: ride, postedRide: postedRide)

    }
    
//    func didSelectRide(ride: RideRecord) {
//        showRideDetail(ride: ride)
//    }
    
    func didTapAddRideButton() {
        goToAddRideCoordinator()
        
    }
    
}

extension YourRidesCoordinator: RideDetailCoordinatorDelegate {
    func didAddUserToRide() {
        
    }
    
    func didEndRide() {
        yourRidesViewController.postedRidesArray.removeAll()
    }
    
    
}

//extension YourRidesCoordinator: AddRideCoordinatorDelegate {
//    func didDismissAddRideViewController() {
//        //self.postedRidesArray.removeAll()
//        //loadPostedFullRides()
//           //loadFirebaseData()
//        //yourRidesArray.removeAll()
//
//
//    }
//
//}

