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
    var docRefLoadUserProfile: DocumentReference!
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
        let userUID = Auth.auth().currentUser?.uid ?? ""
        docRefLoadUserProfile = Firestore.firestore().collection("users").document(userUID)
        
        docRefLoadUserProfile.addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                let data = querySnapshot?.data() ?? [:]

                    if data.count > 0 {
                        self.user = User(name: data["name"] as! String, phoneNumber: data["phoneNumber"] as! String, email: data["email"] as! String, imageDownloadURL: data["imageDownloadURL"] as? String, notificationTokens: data["notificationTokens"] as! [String], image: nil, rating: data["rating"] as? Double, numRatings: data["numRatings"] as? Double)
                        self.profileViewController.imageView.loadImageFromCache(downloadURLString: self.user.imageDownloadURL!) {image in
                            
                            self.profileViewController.imageView.image = image
                        }
                        self.profileViewController.nameLabel.text = self.user.name
                        self.profileViewController.phoneNumberLabel.text = self.user.phoneNumber
                        self.profileViewController.emailLabel.text = self.user.email

                    }
               // }
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
