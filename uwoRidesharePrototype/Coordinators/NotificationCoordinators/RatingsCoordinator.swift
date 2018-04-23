//
//  RatingsCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-04-23.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol RatingsCoordinatorDelegate: class {
    
}

class RatingsCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    
    
    weak var delegate: RatingsCoordinatorDelegate?
    //var docRef: DocumentReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let ratingStoryboard = UIStoryboard.init(name: "Ratings", bundle: nil)
        let ratingsVC = ratingStoryboard.instantiateViewController(withIdentifier: "ratings") as! RatingsViewController
        navigationController?.pushViewController(ratingsVC, animated: true)

    }
    
}
