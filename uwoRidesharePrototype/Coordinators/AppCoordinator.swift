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
    var authViewController: UINavigationController?

    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
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
                
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                //print("addstatedidchange listener hit")
                //print(uid)
                //print(email)
                self.checkTerms()
                
                

                // let photoURL = user.photoURL
            } else {
                self.showAuthentication()
            }
        }
    }
    
    func checkTerms() {
        if self.termsAccepted == false {
            self.showTerms()
        } else {
            self.checkIfUserHasBeenCreated()
        }
    }
    
    func checkIfUserHasBeenCreated() {
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
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        authViewController?.dismiss(animated: true, completion: nil)
        // ye
    }
    
    func showTerms() {
        let termsCoordinator = TermsCoordinator(navigationController: navigationController!)
        termsCoordinator.delegate = self as TermsCoordinatorDelegate
        termsCoordinator.start()
        childCoordinators.append(termsCoordinator)
    }
    
    func showCreateUser() {
        
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
      
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    
}
