//
//  AuthViewController.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-17.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuthUI
import FBSDKCoreKit
import FirebaseFacebookAuthUI

let providers: [FUIAuthProvider] = [
    FUIFacebookAuth(),
]

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.providers = providers
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self as? FUIAuthDelegate
        
        let authViewController = authUI!.authViewController()
        
        self.present(authViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        print("signed in")
        // handle user and error as necessary
    }

    
}

