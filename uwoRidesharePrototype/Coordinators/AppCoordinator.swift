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

class AppCoordinator: NSObject, FUIAuthDelegate, LaunchViewControllerDelegate {

    var authStoryboard: UIStoryboard!
    var launchVC: LaunchViewController!
    var handle: AuthStateDidChangeListenerHandle!
    var authUI: FUIAuth?

    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }
    
    func start() {
        authStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        launchVC = authStoryboard.instantiateViewController(withIdentifier: "launch") as! LaunchViewController
        launchVC.view.backgroundColor = UIColor.white
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
                print("addstatedidchange listener hit")
                print(uid)
                print(email)
                // let photoURL = user.photoURL
            } else {
                self.showAuthentication()
            }
        }
    }
    
    func signOut() {
        try! Auth.auth().signOut()
    }
    
    func showAuthentication() {
        authUI = FUIAuth.defaultAuthUI()
        authUI?.providers = providers
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self as FUIAuthDelegate
        
        let authViewController = authUI!.authViewController()
        
        launchVC.present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // ye
    }

}
