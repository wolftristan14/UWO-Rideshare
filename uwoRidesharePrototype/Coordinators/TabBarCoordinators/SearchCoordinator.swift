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
import AlgoliaSearch

protocol SearchCoordinatorDelegate: class {
    
}

class SearchCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    
    var searchViewController: SearchViewController!
    var counter: Bool!
    var timer: Timer!
    
    weak var delegate: SearchCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {

            searchViewController = navigationController?.visibleViewController?.childViewControllers[0] as! SearchViewController
        print(searchViewController)

        searchViewController.delegate = self

        searchViewController.tabBarController?.navigationItem.title = "Search"

    }
    

    func showRideDetail(ride: RideRecord) {
        let rideDetailCoordinator = RideDetailCoordinator(navigationController: navigationController!)
        rideDetailCoordinator.delegate = self as RideDetailCoordinatorDelegate
        rideDetailCoordinator.selectedRide = ride
        rideDetailCoordinator.isParentSearchVC = true
   
        rideDetailCoordinator.start()
        
        childCoordinators.append(rideDetailCoordinator)
        
        
    }
    
    
}

extension SearchCoordinator: SearchViewControllerDelegate {

    
    func didSelectRide(ride: RideRecord) {
        showRideDetail(ride: ride)
        print("ride when its in search coord:\(ride)")
    }
    

    
}

extension SearchCoordinator: RideDetailCoordinatorDelegate {
    func didAddUserToRide() {
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                print("timer fired")
                self.searchViewController.rideSearcher.search()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
}



