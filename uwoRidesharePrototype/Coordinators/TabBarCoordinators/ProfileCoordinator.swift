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
    var profileViewController: ProfileViewController!
   
    var user: User!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func start() {
        profileViewController = navigationController?.visibleViewController?.childViewControllers[2] as!ProfileViewController
        profileViewController.delegate = self as ProfileViewControllerDelegate

    }
    
    
    func goToEditProfileCoordinator(image: UIImage) {
        let createUserCoordinator = CreateUserCoordinator(navigationController: navigationController!)
        createUserCoordinator.delegate = self as CreateUserCoordinatorDelegate
        createUserCoordinator.isNavBarHidden = false
        createUserCoordinator.isNameHidden = true
        createUserCoordinator.user = user
        user.image = image
        createUserCoordinator.start()

        childCoordinators.append(createUserCoordinator)
    }
    
    
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didTapEditProfileButton(image: UIImage, user: User) {
        self.user = user
        goToEditProfileCoordinator(image: image)
    }
    
    func didTapSignOutButton() {
        try! Auth.auth().signOut()
        navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension ProfileCoordinator: CreateUserCoordinatorDelegate {
    func didDismissCreateUserViewController() {
        
    }
    
    
}
