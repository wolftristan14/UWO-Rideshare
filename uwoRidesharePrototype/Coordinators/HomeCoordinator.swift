//
//  HomeCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-20.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

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
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "home")
        // set as delegate for homevc
        navigationController?.pushViewController(homeViewController, animated: true)
        
    }
    
}
