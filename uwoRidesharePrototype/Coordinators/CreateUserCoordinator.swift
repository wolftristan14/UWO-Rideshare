//
//  CreateUserCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Foundation


protocol CreateUserCoordinatorDelegate: class {
    
}

class CreateUserCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    weak var delegate: CreateUserCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let storyboard = UIStoryboard.init(name: "CreateUser", bundle: nil)
        let createUserVC = storyboard.instantiateViewController(withIdentifier: "createuser") as! CreateUserViewController
        createUserVC.delegate = self as? CreateUserViewControllerDelegate
        navigationController?.pushViewController(createUserVC, animated: true)
    }

}

extension CreateUserCoordinator: CreateUserViewControllerDelegate {
    func didFinishCreatingUser(firstName: String, lastName: String, image: UIImage) {
        //write to firebase
    }
    
    
    
}
