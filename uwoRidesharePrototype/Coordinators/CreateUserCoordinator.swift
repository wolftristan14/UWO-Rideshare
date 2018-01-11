//
//  CreateUserCoordinator.swift
//  uwoRidesharePrototype
//
//  Created by Tristan Wolf on 2017-12-23.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import UIKit
import Foundation
import Firebase


protocol CreateUserCoordinatorDelegate: class {
   func didDismissCreateUserViewController()
}

class CreateUserCoordinator: NSObject {
    
    var navigationController: UINavigationController?
    weak var delegate: CreateUserCoordinatorDelegate?
    var childCoordinators = [NSObject]()
    var ref: DocumentReference!

    
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
        ref = Firestore.firestore().document("users/\(firstName)")
        ref.setData([
            "firstName": firstName,
            "lastName": lastName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didDismissCreateUserViewController()
                print("Document added with ID: \(self.ref!.documentID)")
                
            }
        }
    }
    
    
    
}
