//
//  RideDetailCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-02-05.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase


protocol RideDetailCoordinatorDelegate: class {
    
}

class RideDetailCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var selectedRide: Ride!
    
    weak var delegate: RideDetailCoordinatorDelegate?
    var collRef: Query!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "RideDetail", bundle: nil)
        let rideDetailVC = storyboard.instantiateViewController(withIdentifier: "ridedetail") as! RideDetailViewController
        rideDetailVC.selectedRide = selectedRide
       // rideDetailVC.delegate = self as RideDetailViewControllerDelegate
        navigationController?.pushViewController(rideDetailVC, animated: true)
    }
    
    
}
