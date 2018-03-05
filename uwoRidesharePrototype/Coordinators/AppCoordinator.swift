//
//  AppCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-06.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuthUI
import FBSDKCoreKit
import FirebaseFacebookAuthUI
import Firebase

let providers: [FUIAuthProvider] = [
    FUIFacebookAuth()
]

protocol AppCoordinatorDelegate: class {
    
}

class AppCoordinator: NSObject, FUIAuthDelegate {
    
    var mainStoryboard: UIStoryboard!
    var launchVC: LaunchViewController!
    var handle: AuthStateDidChangeListenerHandle!
    var authUI: FUIAuth?
    var termsAccepted = false
    var accountCreated = false
    var authViewController: UINavigationController?
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    var docRef: DocumentReference!
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor.flatPurpleDark
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.flatWhite, NSAttributedStringKey.font: UIFont.init(name: "Times New Roman", size: 20) ?? UIFont.boldSystemFont(ofSize: 25)]
        
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FirebaseAuth.User?, error: Error?) {
        checkUser(user: user!)
    }
    
    func start() {
        mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        launchVC = mainStoryboard.instantiateViewController(withIdentifier: "launch") as! LaunchViewController
        launchVC.delegate = self
        navigationController?.pushViewController(launchVC, animated: true)
        checkAuth()
        
    }
    
    func checkAuth() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("CURRENTUSER::\(Auth.auth().currentUser)")
                
                let uid = user.uid
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let email = user.email
                print("addstatedidchange listener hit")
                print(uid)
                print(email)
                
                
                //checks if the authenticated user has made a profile yet
                if self.navigationController?.visibleViewController == self.launchVC {
                    self.checkUser(user: user)
                }
            } else {
                self.showTerms()
                
            }
        }
    }
    
    func checkUser(user: FirebaseAuth.User) {
        self.docRef = Firestore.firestore().collection("users").document(user.email!)
        
        
        self.docRef.getDocument { (document, error) in
            if (document?.exists)! {
                print("hit show home")
                self.showHome()
            } else {
                self.showCreateUser()
                print("Document does not exist")
            }
        }
        
        
    }
    
    
    func checkTerms() {
        if termsAccepted == false {
            showTerms()
        } else {
            showAuthentication()
        }
    }
    
    func checkIfUserHasBeenCreated() {
        if accountCreated == false {
            showCreateUser()
        } else {
            showHome()
        }
        // check for database details on current user //do you need email in database to get this?
    }
    
    
    private func showAuthentication() {
        authUI = FUIAuth.defaultAuthUI()
        authUI?.providers = providers
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self as FUIAuthDelegate
        
        authViewController = authUI!.authViewController()
        
        authViewController?.isNavigationBarHidden = true
        launchVC.present(authViewController!, animated: true, completion: nil)
    }
    

    
    
    func showTerms() {
        let termsCoordinator = TermsCoordinator(navigationController: navigationController!)
        termsCoordinator.delegate = self as TermsCoordinatorDelegate
        termsCoordinator.start()
        childCoordinators.append(termsCoordinator)
    }
    
    func showCreateUser() {
        let createUserCoordinator = CreateUserCoordinator(navigationController: navigationController!)
        createUserCoordinator.delegate = self as CreateUserCoordinatorDelegate
        createUserCoordinator.start()
        childCoordinators.append(createUserCoordinator)
    }
    
    
    func showHome() {
        let homeCoordinator = HomeCoordintor(navigationController: navigationController!)
        homeCoordinator.delegate = self as HomeCoordinatorDelegate
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
    
    
}

extension AppCoordinator: LaunchViewControllerDelegate {
    
    func signOut() {
        try! Auth.auth().signOut()
    }
    
}

extension AppCoordinator: TermsCoordinatorDelegate {
    
    func didAcceptTerms() {
        print("termsAccepted")
        termsAccepted = true
        checkTerms()
    }
}

extension AppCoordinator: CreateUserCoordinatorDelegate {
    func didDismissCreateUserViewController() {
        accountCreated = true
        checkIfUserHasBeenCreated()
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    
}


