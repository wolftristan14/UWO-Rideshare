//
//  HomeCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-20.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol HomeCoordinatorDelegate: class {
    
}


class HomeCoordintor: NSObject {
    
    var navigationController: UINavigationController?
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        print("home coordinator start method hit")
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "home")
        let yourRidesViewController = homeViewController.childViewControllers[1] as! YourRidesViewController
        yourRidesViewController.delegate = self as YourRidesViewControllerDelegate
        let profileViewController = homeViewController.childViewControllers[2] as! ProfileViewController
        profileViewController.delegate = self as ProfileViewControllerDelegate
        // set as delegate for homevc
        navigationController?.pushViewController(homeViewController, animated: true)
        
    }
    
    func goToAddRideCoordinator() {
        
        let addRideCoordinator = AddRideCoordinator(navigationController: navigationController!)
        addRideCoordinator.delegate = self as? AddRideViewControllerDelegate
        addRideCoordinator.start()
        childCoordinators.append(addRideCoordinator)
    }
    
}

extension HomeCoordintor: YourRidesViewControllerDelegate {
    func didTapAddRideButton() {
        goToAddRideCoordinator()
    }
    
}

extension HomeCoordintor: ProfileViewControllerDelegate {
    func didTapSignOutButton() {
        try! Auth.auth().signOut()
    navigationController?.popViewController(animated: true)

    }
    
}

