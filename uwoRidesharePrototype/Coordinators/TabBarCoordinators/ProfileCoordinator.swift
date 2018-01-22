//
//  ProfileCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2018-01-22.
//  Copyright © 2018 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol ProfileCoordinatorDelegate: class {
    
}

class ProfileCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()

    
    weak var delegate: ProfileCoordinatorDelegate?
    var docRef: DocumentReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        let profileViewController = navigationController?.visibleViewController?.childViewControllers[2] as!ProfileViewController
        profileViewController.delegate = self as! ProfileViewControllerDelegate
    }
    
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didTapSignOutButton() {
        try! Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
        
    }
    
}
