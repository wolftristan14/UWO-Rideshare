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
    var collRef: CollectionReference!
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
        loadFirebaseData()
        
    }
    
    func loadFirebaseData()  {
        collRef = Firestore.firestore().collection("users")
        
        collRef.whereField("email", isEqualTo: Auth.auth().currentUser?.email ?? "ERROR").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    if document.data().count > 0 {
                        
                        self.user = User(name: document.data()["name"] as! String, phoneNumber: document.data()["phoneNumber"] as! String, email: document.data()["email"] as! String, imageDownloadURL: document.data()["imageDownloadURL"] as? String, notificationTokens: document.data()["notificationTokens"] as! [String], image: nil)
                        self.profileViewController.imageView.loadImageFromCache(downloadURLString: self.user.imageDownloadURL!) {image in
                            
                            self.profileViewController.imageView.image = image
                        }
                        self.profileViewController.nameLabel.text = self.user.name
                        self.profileViewController.phoneNumberLabel.text = self.user.phoneNumber
                        self.profileViewController.emailLabel.text = self.user.email

                    }
                }
            }
        }
        
    }
    
    func goToEditProfileCoordinator(image: UIImage) {
        let createUserCoordinator = CreateUserCoordinator(navigationController: navigationController!)
        createUserCoordinator.delegate = self as? CreateUserCoordinatorDelegate
        createUserCoordinator.isNavBarHidden = false
        createUserCoordinator.isNameHidden = true
        createUserCoordinator.user = user
        user.image = image
        createUserCoordinator.start()

        childCoordinators.append(createUserCoordinator)
    }
    
    
}

extension ProfileCoordinator: ProfileViewControllerDelegate {
    func didTapEditProfileButton(image: UIImage) {
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
