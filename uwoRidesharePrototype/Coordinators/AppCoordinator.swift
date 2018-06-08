//
//  AppCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-06.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI
import FBSDKCoreKit
import Firebase

let providers: [FUIAuthProvider] = [
    FUIFacebookAuth()
]

protocol AppCoordinatorDelegate: class {
    
}

class AppCoordinator: NSObject, FUIAuthDelegate {
    
    var mainStoryboard: UIStoryboard!
    var launchVC: LaunchViewController!
    var rootVC: UIViewController!
    var handle: AuthStateDidChangeListenerHandle!
    var authUI: FUIAuth?
    var termsAccepted = false
    var accountCreated = false
    var authViewController: UINavigationController?
    
    var navigationController: UINavigationController?
    var childCoordinators = [NSObject]()
    var checkUserdocRef: DocumentReference!
    
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
        mainStoryboard = UIStoryboard.init(name: "Root", bundle: nil)
        rootVC = mainStoryboard.instantiateViewController(withIdentifier: "root")
//        launchVC = mainStoryboard.instantiateViewController(withIdentifier: "root") //as! LaunchViewController
        //launchVC.delegate = self
        navigationController?.pushViewController(rootVC, animated: true)
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
                if self.navigationController?.visibleViewController == self.rootVC {
                    self.checkUser(user: user)
                }
            } else {
                self.showAuthentication()
            }
        }
    }
    
    func checkUser(user: FirebaseAuth.User) {
        self.checkUserdocRef = Firestore.firestore().collection("users").document(user.uid)
        
        
        self.checkUserdocRef.getDocument { (document, error) in
            if (document?.exists)! {
                print("hit show home")
                self.showHome()
            } else {
                self.showCreateUser()
                print("Document does not exist")
            }
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
        
        //authViewController?.isNavigationBarHidden = true
       // launchVC.present(authViewController!, animated: true, completion: nil)
        rootVC.present(authViewController!, animated: true, completion: nil)
    }
    
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        return CustomAuthPickerViewController(authUI: authUI)
    }
    
    func emailEntryViewController(forAuthUI authUI: FUIAuth) -> FUIEmailEntryViewController {
        return CustomEmailEntryViewController(authUI: authUI)
    }
    
    func passwordRecoveryViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordRecoveryViewController {
        return CustomPasswordRecoveryViewController(authUI: authUI, email: email)

    }
    
    func passwordSignInViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignInViewController {
        return CustomPasswordSignInViewController(authUI: authUI, email: email)
 
    }
    
    func passwordSignUpViewController(forAuthUI authUI: FUIAuth, email: String) -> FUIPasswordSignUpViewController {
        return CustomPasswordSignUpViewController(authUI: authUI, email: email)

    }
    
    func passwordVerificationViewController(forAuthUI authUI: FUIAuth, email: String, newCredential: AuthCredential) -> FUIPasswordVerificationViewController {
        
        return CustomPasswordVerificationViewController(authUI: authUI, email: email, newCredential: newCredential)

    }
    
    

    
    func showCreateUser() {
        let createUserCoordinator = CreateUserCoordinator(navigationController: navigationController!)
        createUserCoordinator.delegate = self as CreateUserCoordinatorDelegate
        createUserCoordinator.isNavBarHidden = true
        createUserCoordinator.isNameHidden = false
        createUserCoordinator.start()
        childCoordinators.append(createUserCoordinator)
    }
    
    
    func showHome() {
        let homeCoordinator = HomeCoordintor(navigationController: navigationController!)
        homeCoordinator.delegate = self as HomeCoordinatorDelegate
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
    
    func showRatings(driverid: String, driverName: String) {
        let ratingsCoordinator = RatingsCoordinator(navigationController: navigationController!)
        ratingsCoordinator.driverid = driverid
        ratingsCoordinator.driverName = driverName
        ratingsCoordinator.delegate = self as? RatingsCoordinatorDelegate
        ratingsCoordinator.start()
        childCoordinators.append(ratingsCoordinator)
    }
    
    func showNotification(notification: [String:AnyObject]) {
        let notificationStoryboard = UIStoryboard.init(name: "Notifications", bundle: nil)
        let notificationVC = notificationStoryboard.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
        notificationVC.notification = notification
        navigationController?.pushViewController(notificationVC, animated: true)
   
    }
    
    
}

//extension AppCoordinator: LaunchViewControllerDelegate {
//
//    func signOut() {
//        try! Auth.auth().signOut()
//    }
//
//}

extension AppCoordinator: CreateUserCoordinatorDelegate {
    func didDismissCreateUserViewController() {
        accountCreated = true
        checkIfUserHasBeenCreated()
    }
}

extension AppCoordinator: HomeCoordinatorDelegate {
    
}

extension AppCoordinator: RatingsCoordinatorDelegate {
    func didFinishUpdatingDriverRating() {
        self.checkAuth()
    }
}


