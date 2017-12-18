//
//  AuthCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-06.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase



protocol AuthCoordinatorDelegate: class {
    func didAuth()
}

class AuthCoordinator: NSObject /*AuthViewControllerDelegate*/ {
    
    
    var navigationController: UINavigationController?
    var delegate: AuthCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        let authStoryboard = UIStoryboard.init(name: "Auth", bundle: nil)
        let backViewController = authStoryboard.instantiateViewController(withIdentifier: "back")
        backViewController.view.backgroundColor = UIColor.white
        //tbis will be main background controller
        navigationController?.pushViewController(backViewController, animated: true)
    }
    
    
    
    func didSignUp() {
        //navigationController?.viewControllers.popLast()
        navigationController?.viewControllers.removeAll()
        //navigationController?.popViewController(animated: true)
        self.delegate?.didAuth()
    }
    
    
    
    
}

