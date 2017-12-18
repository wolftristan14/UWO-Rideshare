//
//  AppCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-06.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorDelegate: class {
    
}

class AppCoordinator: NSObject, AuthCoordinatorDelegate {
    func didAuth() {
        
    }
    
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        
        var isLoggedIn = false
        
        if isLoggedIn {
            //showContent()
        }
        else {
            showAuthentication()
        }
    }
    
    func showAuthentication() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController!)
        authCoordinator.delegate = self as AuthCoordinatorDelegate
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }

}
